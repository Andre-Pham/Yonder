//
//  BurnStatusEffect.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class BurnStatusEffect: StatusEffect {
    
    public let damage: Int
    
    init(damage: Int) {
        self.damage = damage
    }
    
    func applyEffect(actor: ActorAbstract) {
        actor.damage(for: damage)
    }
    
}
