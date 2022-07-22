//
//  ActorPublisher.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class ActorPublisher {
    
    static private var onActorAttackSubscribers = [WeakOnActorAttackSubscriber]()
    static private var afterActorAttackSubscribers = [WeakAfterActorAttackSubscriber]()
    
    static func addSubscriber(_ subscriber: OnActorAttackSubscriber) {
        self.onActorAttackSubscribers.append(WeakOnActorAttackSubscriber(value: subscriber))
    }
    
    static func addSubscriber(_ subscriber: AfterActorAttackSubscriber) {
        self.afterActorAttackSubscribers.append(WeakAfterActorAttackSubscriber(value: subscriber))
    }
    
    static func publishOnActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        for sub in Self.onActorAttackSubscribers {
            sub.value?.onActorAttack(actor: actor, weapon: weapon, target: target)
        }
    }
    
    static func publishAfterActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        for sub in Self.afterActorAttackSubscribers {
            sub.value?.afterActorAttack(actor: actor, weapon: weapon, target: target)
        }
    }
    
}
