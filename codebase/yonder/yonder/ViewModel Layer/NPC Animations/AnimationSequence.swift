//
//  AnimationSequence.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import SwiftUI

class AnimationSequence {
    
    private let spriteSheet: UIImage
    private var loop: Bool = true
    private var delegate: SequenceDelegate? = nil
    private var timer = SequenceTimer()
    private(set) var isPlaying = false
    private var playbackSpeed = 1.0
    private let frameDuration: Double
    private let frameOrigins: [SpriteSheetCoord]
    public let frameSize: (width: Int, height: Int)
    private var frameIndex = 0 {
        didSet {
            self.delegate?.onNewFrame(self.frame)
        }
    }
    private var frameCount: Int {
        return self.frameOrigins.count
    }
    private var lastFrameIndex: Int {
        return self.frameCount - 1
    }
    private var frameRect: CGRect {
        guard self.frameOrigins.count > self.frameIndex else {
            // This has triggered once in the history of testing - catch the error in case this for some reason fails (though it should never)
            assertionFailure("Invalid frame origin/index")
            return CGRect()
        }
        let origin = self.frameOrigins[self.frameIndex]
        return CGRect(x: origin.x, y: origin.y, width: self.frameSize.width, height: self.frameSize.height)
    }
    public var frame: Image {
        if let cropped = self.spriteSheet.cropped(toRect: self.frameRect) {
            return Image(uiImage: cropped)
        }
        assertionFailure("Sprite sheet failed to be cropped")
        return Image(uiImage: UIImage())
    }
    
    init(
        spriteSheet: UIImage,
        frameDuration: Double,
        frameOrigins: [SpriteSheetCoord],
        frameSize: (width: Int, height: Int)
    ) {
        self.spriteSheet = spriteSheet
        self.frameDuration = frameDuration
        self.frameOrigins = frameOrigins
        self.frameSize = frameSize
    }
    
    deinit {
        // Clean up dependencies
        self.setDelegate(to: nil)
    }
    
    func setDelegate(to delegate: SequenceDelegate?) {
        self.delegate = delegate
    }
    
    func play() {
        guard !self.isPlaying else {
            return
        }
        self.isPlaying = true
        self.timer.start(withTimeInterval: self.frameDuration/self.playbackSpeed) { [weak self] in
            // Ensure this is a weak referenced closure
            // Otherwise the timer, this AnimationSequence, and this closure is retained in memory, even if not stored or referenced anywhere
            guard let self = self else { return }
            self.incrementFrame()
            if self.frameIndex == self.lastFrameIndex {
                if !self.loop {
                    self.pause()
                }
                self.delegate?.onSequenceEnd()
            }
        }
    }
    
    func pause() {
        self.isPlaying = false
        self.timer.stop()
    }
    
    func reset() {
        self.isPlaying = false
        self.timer.stop()
        self.frameIndex = 0
    }
    
    func restart() {
        self.reset()
        self.play()
    }
    
    func skipToEnd() {
        self.isPlaying = false
        self.timer.stop()
        self.frameIndex = self.lastFrameIndex
    }
    
    func setPlaybackSpeed(to speed: Double) {
        self.playbackSpeed = speed
        if self.isPlaying {
            // Pause/play resets the timer to use the new playback speed
            self.pause()
            self.play()
        }
    }
    
    func setLoopBehaviour(to shouldLoop: Bool) {
        self.loop = shouldLoop
    }
    
    private func incrementFrame() {
        self.frameIndex = (self.frameIndex + 1)%self.frameCount
    }
    
}
