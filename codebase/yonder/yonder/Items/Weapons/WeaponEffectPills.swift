//
//  WeaponEffectPills.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

class BurnStatusEffectEffectPill: WeaponEffectPill {
    
    var priority: WeaponEffectPillPriority = .first
    let tickDamage: Int
    
    init(tickDamage: Int) {
        self.tickDamage = tickDamage
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addStatusEffect(BurnStatusEffect(damage: self.tickDamage))
    }
    
    func getValue() -> Int {
        return 10*self.tickDamage
    }
    
}
