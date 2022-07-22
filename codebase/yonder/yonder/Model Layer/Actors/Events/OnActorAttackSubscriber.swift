//
//  OnActorAttackSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

protocol OnActorAttackSubscriber: AnyObject {
    
    func onActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract)
    
}

class WeakOnActorAttackSubscriber {
    
    private(set) weak var value: OnActorAttackSubscriber?

    init(value: OnActorAttackSubscriber?) {
        self.value = value
    }
    
}
