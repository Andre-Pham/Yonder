//
//  AfterActorAttackSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class AfterActorAttackPublisher {
    
    static private var subscribers = [WeakAfterActorAttackSubscriber]()
    
    static func subscribe(_ subscriber: AfterActorAttackSubscriber) {
        self.subscribers.append(WeakAfterActorAttackSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        for sub in Self.subscribers {
            sub.value?.afterActorAttack(actor: actor, weapon: weapon, target: target)
        }
    }
    
}


protocol AfterActorAttackSubscriber: AnyObject {
    
    func afterActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract)
    
}


private class WeakAfterActorAttackSubscriber {
    
    private(set) weak var value: AfterActorAttackSubscriber?

    init(value: AfterActorAttackSubscriber?) {
        self.value = value
    }
    
}
