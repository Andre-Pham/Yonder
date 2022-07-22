//
//  AfterActorAttackSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

protocol AfterActorAttackSubscriber: AnyObject {
    
    func afterActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract)
    
}

class WeakAfterActorAttackSubscriber {
    
    private(set) weak var value: AfterActorAttackSubscriber?

    init(value: AfterActorAttackSubscriber?) {
        self.value = value
    }
    
}
