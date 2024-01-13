//
//  OnTurnStart.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

/// Triggers on the start of every new turn (including when there is no foe and the player just travelled to a new location)
class OnTurnStartPublisher {
    
    static private var subscribers = [WeakOnTurnStartSubscriber]()
    
    static func subscribe(_ subscriber: OnTurnStartSubscriber) {
        self.subscribers.append(WeakOnTurnStartSubscriber(value: subscriber))
    }
    
    static func publish(player: Player, foe: Foe?) {
        for sub in Self.subscribers {
            sub.value?.onTurnStart(player: player, foe: foe)
        }
    }
    
}


protocol OnTurnStartSubscriber: AnyObject {
    
    func onTurnStart(player: Player, foe: Foe?)
    
}


private class WeakOnTurnStartSubscriber {
    
    private(set) weak var value: OnTurnStartSubscriber?

    init(value: OnTurnStartSubscriber?) {
        self.value = value
    }
    
}
