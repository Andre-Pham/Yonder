//
//  FullHealTimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class FullHealTimedEvent: TimedEventAbstract {
    
    var timeRemaining: Int {
        didSet {
            if timeRemaining == 0 {
                self.triggerEvent()
            }
        }
    }
    let target: ActorAbstract
    
    init(timeToTrigger: Int, target: ActorAbstract) {
        self.timeRemaining = timeToTrigger
        self.target = target
    }
    
    func decrementTimeRemaining() {
        self.timeRemaining -= 1
    }
    
    func triggerEvent() {
        self.target.restoreHealth(for: target.maxHealth)
    }
    
}
