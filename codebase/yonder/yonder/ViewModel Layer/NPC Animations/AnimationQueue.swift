//
//  AnimationQueue.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

class AnimationQueue: AnimationManager {
    
    private var defaultSequence: SequenceCode
    private var queue = [SequenceCode]()
    private var isEnded = false
    
    init?(fileID: String, defaultAnimation: SequenceCode) {
        self.defaultSequence = defaultAnimation
        super.init(fileID: fileID, initialSequence: defaultAnimation)
        self.play()
    }
    
    /// Callback triggered every time the queue length changes
    private func onQueueChangeLength() {
        // The playback speed is proportional to the queue length
        // This means as the queue grows, animation playback speed grows to "catch up"
        // Empty -> 1x, 1 sequence waiting -> 2x, 2 sequences waiting -> 3x, etc.
        self.setPlaybackSpeed(to: 1.0*Double(self.queue.count + 1))
    }
    
    /// Set the default animation sequence
    func changeDefaultSequence(to code: SequenceCode) {
        self.defaultSequence = code
    }
    
    /// Add a sequence to the queue.
    func addToQueue(sequence: SequenceCode) {
        if self.isEnded {
            self.reinitialiseQueue()
        }
        if self.queue.isEmpty && self.activeSequenceCode == self.defaultSequence {
            self.setSequence(to: sequence)
        } else {
            self.queue.append(sequence)
            self.onQueueChangeLength()
        }
    }
    
    /// Clear the queue, resetting the active sequence to the default.
    func clearQueue() {
        self.queue.removeAll()
        self.onQueueChangeLength()
        self.setSequence(to: self.defaultSequence)
    }
    
    /// Flags the queue to stop serving sequences.
    /// After the active sequence ends it will loop/end forever (until the queue is reinitialised).
    /// Example:
    /// ```
    /// // Clear queue to immediately play next added sequence
    /// self.queue.clearQueue()
    /// // Play the death sequence
    /// self.queue.addToQueue(sequence: .death)
    /// // After the death sequence ends, don't play anything else
    /// self.queue.endQueue()
    /// ```
    func endQueue() {
        self.isEnded = true
    }
    
    /// Assumes the queue has ended. Clear the queue and start serving any new sequences.
    func reinitialiseQueue() {
        assert(self.isEnded, "Queue is being reinitialised but it hasn't ended - use clearQueue() instead")
        self.isEnded = false
        self.clearQueue()
    }
    
    override func onSequenceEnd() {
        super.onSequenceEnd()
        if self.isEnded {
            // If the queue has ended, don't serve any more sequences
            return
        }
        if !self.queue.isEmpty {
            let nextSequence = self.queue.removeFirst()
            self.onQueueChangeLength()
            self.setSequence(to: nextSequence)
        } else if self.activeSequenceCode != self.defaultSequence {
            self.setSequence(to: self.defaultSequence)
        }
    }
    
}
