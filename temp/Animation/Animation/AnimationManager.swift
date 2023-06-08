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

class AnimationManager: ObservableObject, ManagesSequences {

    private let hitSequence: AnimationSequence
    private let deathSequence: AnimationSequence
    private let breathingSequence: AnimationSequence
    private let idleSequence: AnimationSequence
    private let attackSequence: AnimationSequence
    private let runSequence: AnimationSequence
    
    private var activeSequence: AnimationSequence
    
    @Published private(set) var frame: Image

    /// id, e.g. E0001
    init?(id: String) {
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
        guard let hit = builder.build(prefix: "hit"),
              let death = builder.build(prefix: "death"),
              let breath = builder.build(prefix: "breathing"),
              let idle = builder.build(prefix: "idle"),
              let attack = builder.build(prefix: "attack"),
              let run = builder.build(prefix: "run") else {
            assertionFailure("Sequence(s) couldn't be built")
            return nil
        }
        self.hitSequence = hit
        self.deathSequence = death
        self.breathingSequence = breath
        self.idleSequence = idle
        self.attackSequence = attack
        self.runSequence = run
        
        self.activeSequence = self.idleSequence
        self.frame = self.activeSequence.frame
        
        [self.hitSequence, self.deathSequence, self.breathingSequence, self.idleSequence, self.attackSequence, self.runSequence].forEach({
            $0.setDelegate(to: self)
        })
    }
    
    func onNewFrame(_ frame: Image) {
        self.frame = frame
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
