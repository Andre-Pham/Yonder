//
//  AnimationManager.swift
//  Animation
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

class AnimationSequenceBuilder {
    
    private let spriteSheet: UIImage
    private let framesDataJSON: JSON
    
    init(spriteSheet: UIImage, framesDataJSON: JSON) {
        self.spriteSheet = spriteSheet
        self.framesDataJSON = framesDataJSON
    }
    
    func build(prefix: String) -> AnimationSequence? {
        guard let frameDuration = self.framesDataJSON["\(prefix)_frame_duration"].double else {
            assertionFailure("Frame duration could not be read from JSON")
            return nil
        }
        guard let frameOriginsJSON = self.framesDataJSON["\(prefix)_coords"].array else {
            assertionFailure("Frame origins could not be read from JSON")
            return nil
        }
        var frameOrigins = [ImageCoords]()
        for originJSON in frameOriginsJSON {
            guard let x = originJSON["x"].int, let y = originJSON["y"].int else {
                assertionFailure("Origin coordinate could not be read from JSON")
                return nil
            }
            frameOrigins.append(ImageCoords(x: x, y: y))
        }
        guard let frameWidth = self.framesDataJSON["frame_width"].int,
              let frameHeight = self.framesDataJSON["frame_height"].int else {
            assertionFailure("Frame width/height could not be read from JSON")
            return nil
        }
        return AnimationSequence(
            spriteSheet: self.spriteSheet,
            frameDuration: frameDuration,
            frameOrigins: frameOrigins,
            frameSize: (width: frameWidth, height: frameHeight)
        )
    }
    
}

enum SequenceKey: String, CaseIterable {
    case hit = "hit"
    case death = "death"
    case breathing = "breathing"
    case idle = "idle"
    case attack = "attack"
    case run = "run"
}

class AnimationManager: ObservableObject, ManagesSequences {
    
    private var sequences = [String: AnimationSequence]()
    private(set) var activeSequenceKey: SequenceKey
    private var activeSequence: AnimationSequence {
        return self.getSequence(self.activeSequenceKey)
    }
    public var isPlaying: Bool {
        return self.activeSequence.isPlaying
    }
    private var playbackSpeed = 1.0
    
    @Published private(set) var frame: Image

    /// id, e.g. E0001
    init?(id: String, initialSequence: SequenceKey) {
        guard let spriteSheet = UIImage(named: "IMG-\(id)") else {
            assertionFailure("Animation ID provided doesn't have corresponding sprite sheet")
            return nil
        }
        guard let framesURL = Bundle.main.url(forResource: "FRAMES-\(id)", withExtension: "json"),
              let framesData = try? Data(contentsOf: framesURL) else {
            assertionFailure("Frames data could not be loaded")
            return nil
        }
        guard let framesDataJSON = try? JSON(data: framesData) else {
            assertionFailure("JSON could not be retrieved from frames data")
            return nil
        }
        let builder = AnimationSequenceBuilder(spriteSheet: spriteSheet, framesDataJSON: framesDataJSON)
        for key in SequenceKey.allCases {
            guard let sequence = builder.build(prefix: key.rawValue) else {
                assertionFailure("Sequence(s) couldn't be built")
                return nil
            }
            self.sequences[key.rawValue] = sequence
        }
        self.activeSequenceKey = initialSequence
        self.frame = self.sequences[initialSequence.rawValue]!.frame
        for key in SequenceKey.allCases {
            self.getSequence(key).setDelegate(to: self)
        }
        self.setup()
    }
    
    func setup() {
        self.getSequence(.death).setLoopBehaviour(to: false)
        self.getSequence(.attack).setLoopBehaviour(to: false)
    }
    
    func setPlaybackSpeed(to speed: Double) {
        self.playbackSpeed = speed
        self.activeSequence.setPlaybackSpeed(to: self.playbackSpeed)
    }
    
    func setSequence(to sequence: SequenceKey) {
        self.activeSequence.stop()
        self.activeSequenceKey = sequence
        self.activeSequence.setPlaybackSpeed(to: self.playbackSpeed)
        self.frame = self.activeSequence.frame
        self.activeSequence.start()
    }
    
    private func getSequence(_ key: SequenceKey) -> AnimationSequence {
        return self.sequences[key.rawValue]!
    }
    
    func onNewFrame(_ frame: Image) {
        self.frame = frame
    }
    
    func onSequenceEnd() {
        
    }
    
    func play() {
        self.activeSequence.start()
    }
    
    func pause() {
        self.activeSequence.pause()
    }
    
    func stop() {
        self.activeSequence.stop()
    }
    
    func restart() {
        self.activeSequence.restart()
    }

}
