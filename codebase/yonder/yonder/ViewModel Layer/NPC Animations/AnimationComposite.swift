//
//  AnimationComposite.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

class AnimationManager: ObservableObject, SequenceDelegate {
    
    private static let SPRITE_SHEET_PREFIX = "IMG-"
    private static let FRAMES_DATA_PREFIX = "FRAMES-"
    
    @Published private(set) var frame: Image
    private var sequences = [String: AnimationSequence]()
    private var playbackSpeed = 1.0
    private(set) var activeSequenceCode: SequenceCode
    private var activeSequence: AnimationSequence {
        return self.getSequence(self.activeSequenceCode)
    }
    public var isPlaying: Bool {
        return self.activeSequence.isPlaying
    }
    
    init?(fileID: String, initialSequence: SequenceCode) {
        guard let spriteSheet = UIImage(named: Self.SPRITE_SHEET_PREFIX + fileID) else {
            assertionFailure("Animation ID provided doesn't have corresponding sprite sheet")
            return nil
        }
        guard let framesURL = Bundle.main.url(forResource: Self.FRAMES_DATA_PREFIX + fileID, withExtension: "json"),
              let framesData = try? Data(contentsOf: framesURL) else {
            assertionFailure("Frames data could not be loaded")
            return nil
        }
        guard let framesDataJSON = try? JSON(data: framesData) else {
            assertionFailure("JSON could not be retrieved from frames data")
            return nil
        }
        let builder = AnimationSequenceBuilder(spriteSheet: spriteSheet, framesDataJSON: framesDataJSON)
        for code in SequenceCode.allCases {
            guard let sequence = builder.build(prefix: code.rawValue) else {
                assertionFailure("Sequence(s) couldn't be built")
                return nil
            }
            self.sequences[code.rawValue] = sequence
        }
        self.activeSequenceCode = initialSequence
        self.frame = self.sequences[self.activeSequenceCode.rawValue]!.frame
        for code in SequenceCode.allCases {
            self.getSequence(code).setDelegate(to: self)
        }
        self.setupSequences()
    }
    
    func setupSequences() {
        self.getSequence(.death).setLoopBehaviour(to: false)
        self.getSequence(.attack).setLoopBehaviour(to: false)
    }
    
    private func getSequence(_ code: SequenceCode) -> AnimationSequence {
        return self.sequences[code.rawValue]!
    }
    
    func setPlaybackSpeed(to speed: Double) {
        self.playbackSpeed = speed
        self.activeSequence.setPlaybackSpeed(to: self.playbackSpeed)
    }
    
    func setSequence(to code: SequenceCode) {
        self.activeSequence.reset()
        self.activeSequenceCode = code
        self.activeSequence.setPlaybackSpeed(to: self.playbackSpeed)
        self.setFrame(to: self.activeSequence.frame)
        self.activeSequence.play()
    }
    
    func onNewFrame(_ frame: Image) {
        self.setFrame(to: frame)
    }
    
    func onSequenceEnd() {
        // Blank
    }
    
    func play() {
        self.activeSequence.play()
    }
    
    func pause() {
        self.activeSequence.pause()
    }
    
    func reset() {
        self.activeSequence.reset()
    }
    
    func restart() {
        self.activeSequence.restart()
    }
    
    func skipToEnd() {
        self.activeSequence.skipToEnd()
    }
    
    private func setFrame(to frame: Image) {
        withAnimation(.none) {
            self.frame = frame
        }
    }
    
}
