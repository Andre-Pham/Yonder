//
//  FullHealTimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class FullHealTimedEvent: TimedEvent {
    
    public let timer: Timer
    private let target: ActorAbstract
    
    init(timeToTrigger: Int, target: ActorAbstract) {
        self.timer = Timer(startTime: timeToTrigger)
        self.target = target
    }
    
    func triggerEvent() {
        self.target.restoreHealth(for: self.target.maxHealth)
    }
    
}
