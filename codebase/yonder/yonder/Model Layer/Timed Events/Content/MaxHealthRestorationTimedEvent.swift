//
//  MaxHealthRestorationTimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class MaxHealthRestorationTimedEvent: TimedEventAbstract {
    
    public let timer: Timer
    
    init(timeToTrigger: Int) {
        self.timer = Timer(startTime: timeToTrigger)
        super.init(name: Strings.TimedEvent.MaxHealthRestoration.Name.local)
    }
    
    required init(_ original: TimedEventPart) {
        let original = original as! Self
        self.timer = original.timer.clone()
        super.init(original)
    }
    
    func triggerEvent(target: ActorAbstract) {
        target.restoreHealth(for: target.maxHealth)
    }
    
    func getIndicativeValue(target: ActorAbstract) -> Int? {
        return nil
    }
    
    func getEffectsDescription() -> String? {
        return Strings.TimedEvent.MaxHealthRestoration.EffectsDescription.local
    }
    
}
