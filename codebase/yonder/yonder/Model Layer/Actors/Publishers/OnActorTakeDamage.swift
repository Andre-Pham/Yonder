//
//  OnActorTakeDamage.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2024.
//

import Foundation

/// Triggers whenever an actor takes damage.
/// Only triggers when they "take damage", not just whenever their health changes. For example a curse that sets the player's health to half wouldn't trigger this.
class OnActorTakeDamagePublisher {
    
    static private var subscribers = [WeakOnActorTakeDamageSubscriber]()
    
    static func subscribe(_ subscriber: OnActorTakeDamageSubscriber) {
        self.subscribers.append(WeakOnActorTakeDamageSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, damageTaken: Int) {
        for sub in Self.subscribers {
            sub.value?.onActorTakeDamage(actor: actor, damageTaken: damageTaken)
        }
    }
    
}


protocol OnActorTakeDamageSubscriber: AnyObject {
    
    func onActorTakeDamage(actor: ActorAbstract, damageTaken: Int)
    
}


private class WeakOnActorTakeDamageSubscriber {
    
    private(set) weak var value: OnActorTakeDamageSubscriber?

    init(value: OnActorTakeDamageSubscriber?) {
        self.value = value
    }
    
}
