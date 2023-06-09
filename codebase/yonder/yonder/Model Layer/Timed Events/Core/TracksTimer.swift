//
//  TracksTimer.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

protocol TracksTimer {
    
    // Being an object instead of a primitive type allows this to be referenced in this protocol's extension
    var timer: TurnTimer { get }
    
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
