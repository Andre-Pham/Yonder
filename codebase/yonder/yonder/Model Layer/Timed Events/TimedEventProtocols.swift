//
//  TimedEventProtocols.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

protocol TracksTimer {
    
    var timer: Timer { get }
    
    func triggerEvent(target: ActorAbstract)
    
}
extension TracksTimer {
    
    var isFinished: Bool {
        return self.timer.isFinished
    }
    
    func decrementTimeRemaining(target: ActorAbstract) {
        self.timer.tickDown()
        if self.timer.isFinished {
            self.triggerEvent(target: target)
        }
    }
    
}
