//
//  AfterPlayerDeath.swift
//  yonder
//
//  Created by Andre Pham on 10/12/2022.
//

import Foundation

class AfterPlayerDeathPublisher {
    
    static private var subscribers = [WeakAfterPlayerDeathSubscriber]()
    
    static func subscribe(_ subscriber: AfterPlayerDeathSubscriber) {
        self.subscribers.append(WeakAfterPlayerDeathSubscriber(value: subscriber))
    }
    
    static func publish(player: Player) {
        for sub in Self.subscribers {
            sub.value?.afterPlayerDeath(player: player)
        }
    }
    
}


protocol AfterPlayerDeathSubscriber: AnyObject {
    
    func afterPlayerDeath(player: Player)
    
}


private class WeakAfterPlayerDeathSubscriber {
    
    private(set) weak var value: AfterPlayerDeathSubscriber?

    init(value: AfterPlayerDeathSubscriber?) {
        self.value = value
    }
    
}
