//
//  TimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

protocol TimedEvent {
    
    var timer: Timer { get }
    
    func triggerEvent()
    
}
extension TimedEvent {
    
    var isFinished: Bool {
        return self.timer.isFinished
    }
    
    func decrementTimeRemaining() {
        self.timer.tickDown()
        if self.timer.isFinished {
            self.triggerEvent()
        }
    }
    
}
