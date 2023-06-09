//
//  AnimationQueue.swift
//  Animation
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

class AnimationQueue: AnimationManager {
    
    private let defaultAnimation: SequenceKey
    private var queue = [SequenceKey]()
    private var isEnded = false
    
    init?(id: String, defaultAnimation: SequenceKey) {
        self.defaultAnimation = defaultAnimation
        super.init(id: id, initialSequence: defaultAnimation)
        self.play()
    }
    
    func onQueueChangeLength() {
        self.setPlaybackSpeed(to: 1.0*Double(self.queue.count + 1))
    }
    
    func clearQueue() {
        self.queue.removeAll()
        self.onQueueChangeLength()
        self.setSequence(to: self.defaultAnimation)
    }
    
    func addToQueue(sequence: SequenceKey) {
        if self.queue.isEmpty && self.activeSequenceKey == self.defaultAnimation {
            self.setSequence(to: sequence)
        } else {
            self.queue.append(sequence)
            self.onQueueChangeLength()
        }
    }
    
    func endQueue() {
        self.isEnded = true
    }
    
    func reinitialiseQueue() {
        self.isEnded = false
        self.clearQueue()
    }
    
    override func onSequenceEnd() {
        super.onSequenceEnd()
        if self.isEnded {
            return
        }
        if !self.queue.isEmpty {
            let nextSequence = self.queue.removeFirst()
            self.onQueueChangeLength()
            self.setSequence(to: nextSequence)
        } else if self.activeSequenceKey != self.defaultAnimation {
            self.setSequence(to: self.defaultAnimation)
        }
    }
    
}
