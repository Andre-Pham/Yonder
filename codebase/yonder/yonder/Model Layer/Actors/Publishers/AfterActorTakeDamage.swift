//
//  AfterActorTakeDamage.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2024.
//

import Foundation

/// Triggers after an actor takes damage.
/// Only triggers when they "take damage", not just whenever their health changes. For example a curse that sets the player's health to half wouldn't trigger this.
class AfterActorTakeDamagePublisher {
    
    static private var subscribers = [WeakAfterActorTakeDamageSubscriber]()
    
    static func subscribe(_ subscriber: AfterActorTakeDamageSubscriber) {
        self.subscribers.append(WeakAfterActorTakeDamageSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, damageTaken: Int) {
        for sub in Self.subscribers {
            sub.value?.afterActorTakeDamage(actor: actor, damageTaken: damageTaken)
        }
    }
    
}


protocol AfterActorTakeDamageSubscriber: AnyObject {
    
    func afterActorTakeDamage(actor: ActorAbstract, damageTaken: Int)
    
}


private class WeakAfterActorTakeDamageSubscriber {
    
    private(set) weak var value: AfterActorTakeDamageSubscriber?

    init(value: AfterActorTakeDamageSubscriber?) {
        self.value = value
    }
    
}
