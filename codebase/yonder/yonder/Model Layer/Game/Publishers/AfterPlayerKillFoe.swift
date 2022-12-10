//
//  AfterPlayerKillFoe.swift
//  yonder
//
//  Created by Andre Pham on 10/12/2022.
//

import Foundation

class AfterPlayerKillFoePublisher {
    
    static private var subscribers = [WeakAfterPlayerKillFoeSubscriber]()
    
    static func subscribe(_ subscriber: AfterPlayerKillFoeSubscriber) {
        self.subscribers.append(WeakAfterPlayerKillFoeSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, foe: Foe) {
        for sub in Self.subscribers {
            sub.value?.afterPlayerKillFoe(player: player, foe: foe)
        }
    }
    
}


protocol AfterPlayerKillFoeSubscriber: AnyObject {
    
    func afterPlayerKillFoe(player: Player, foe: Foe)
    
}


private class WeakAfterPlayerKillFoeSubscriber {
    
    private(set) weak var value: AfterPlayerKillFoeSubscriber?

    init(value: AfterPlayerKillFoeSubscriber?) {
        self.value = value
    }
    
}
