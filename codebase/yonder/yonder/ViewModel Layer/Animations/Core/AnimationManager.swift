//
//  AnimationManager.swift
//  yonder
//
//  Created by Andre Pham on 22/3/2024.
//

import Foundation
import SwiftUI
import SwiftyJSON

class AnimationManager<SequenceCode>: ObservableObject, SequenceDelegate where SequenceCode: RawRepresentable, SequenceCode.RawValue == String, SequenceCode: CaseIterable {
    
    private static var SPRITE_SHEET_PREFIX: String { "IMG-" }
    private static var FRAMES_DATA_PREFIX: String { "FRAMES-" }
    
    @Published private(set) var frame: Image
    private(set) var emptyAnimation = false
    private var sequences = [String: AnimationSequence]()
    private var playbackSpeed = 1.0
    private(set) var activeSequenceCode: SequenceCode
    private var activeSequence: AnimationSequence {
        return self.getSequence(self.activeSequenceCode)
    }
    public var isPlaying: Bool {
        return self.activeSequence.isPlaying
    }
    public var frameSize: CGSize {
        return CGSize(
            width: self.activeSequence.frameSize.width,
            height: self.activeSequence.frameSize.height
        )
    }
    
    init(fileID: String?, initialSequence: SequenceCode) {
        self.activeSequenceCode = initialSequence
        // Set blank frame assuming no fileID was provided
        self.frame = Image(uiImage: UIImage())
        guard let fileID else {
            // No fileID provided - empty animation (completely valid)
            self.emptyAnimation = true
            return
        }
        guard let spriteSheet = UIImage(named: Self.SPRITE_SHEET_PREFIX + fileID) else {
            assertionFailure("Animation ID provided doesn't have corresponding sprite sheet")
            self.emptyAnimation = true
            return
        }
        guard let framesURL = Bundle.main.url(forResource: Self.FRAMES_DATA_PREFIX + fileID, withExtension: "json"),
              let framesData = try? Data(contentsOf: framesURL) else {
            assertionFailure("Frames data could not be loaded")
            self.emptyAnimation = true
            return
        }
        guard let framesDataJSON = try? JSON(data: framesData) else {
            assertionFailure("JSON could not be retrieved from frames data")
            self.emptyAnimation = true
            return
        }
        let builder = AnimationSequenceBuilder(fileID: fileID, spriteSheet: spriteSheet, framesDataJSON: framesDataJSON)
        for code in SequenceCode.allCases {
            guard let sequence = builder.build(prefix: code.rawValue) else {
                assertionFailure("Sequence(s) couldn't be built")
                self.emptyAnimation = true
                return
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
    
    /// Override this in subclasses to setup any sequence behaviour, such as disabling loop behaviour.
    func setupSequences() { }
    
    func setFileID(to fileID: String?) {
        let wasPlaying = self.isPlaying
        self.sequences.removeAll()
        // Set blank frame assuming no fileID was provided
        self.frame = Image(uiImage: UIImage())
        guard let fileID else {
            // No fileID provided - empty animation (completely valid)
            self.emptyAnimation = true
            return
        }
        guard let spriteSheet = UIImage(named: Self.SPRITE_SHEET_PREFIX + fileID) else {
            assertionFailure("Animation ID provided doesn't have corresponding sprite sheet")
            self.emptyAnimation = true
            return
        }
        guard let framesURL = Bundle.main.url(forResource: Self.FRAMES_DATA_PREFIX + fileID, withExtension: "json"),
              let framesData = try? Data(contentsOf: framesURL) else {
            assertionFailure("Frames data could not be loaded")
            self.emptyAnimation = true
            return
        }
        guard let framesDataJSON = try? JSON(data: framesData) else {
            assertionFailure("JSON could not be retrieved from frames data")
            self.emptyAnimation = true
            return
        }
        let builder = AnimationSequenceBuilder(fileID: fileID, spriteSheet: spriteSheet, framesDataJSON: framesDataJSON)
        for code in SequenceCode.allCases {
            guard let sequence = builder.build(prefix: code.rawValue) else {
                assertionFailure("Sequence(s) couldn't be built")
                self.emptyAnimation = true
                return
            }
            self.sequences[code.rawValue] = sequence
        }
        self.frame = self.sequences[self.activeSequenceCode.rawValue]!.frame
        for code in SequenceCode.allCases {
            self.getSequence(code).setDelegate(to: self)
        }
        self.setupSequences()
        self.emptyAnimation = false
        if wasPlaying {
            // Restore state
            self.play()
        }
    }
    
    func getSequence(_ code: SequenceCode) -> AnimationSequence {
        return self.sequences[code.rawValue] ?? NoAnimationSequence()
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
