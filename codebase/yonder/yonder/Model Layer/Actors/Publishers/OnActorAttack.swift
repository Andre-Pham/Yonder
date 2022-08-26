//
//  OnActorAttackSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class OnActorAttackPublisher {
    
    static private var subscribers = [WeakOnActorAttackSubscriber]()
    
    static func subscribe(_ subscriber: OnActorAttackSubscriber) {
        self.subscribers.append(WeakOnActorAttackSubscriber(value: subscriber))
    }
    
    static func publish(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        for sub in Self.subscribers {
            sub.value?.onActorAttack(actor: actor, weapon: weapon, target: target)
        }
    }
    
}


protocol OnActorAttackSubscriber: AnyObject {
    
    func onActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract)
    
}


private class WeakOnActorAttackSubscriber {
    
    private(set) weak var value: OnActorAttackSubscriber?

    init(value: OnActorAttackSubscriber?) {
        self.value = value
    }
    
}
