//
//  BurnStatusEffectEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class BurnStatusEffectEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public let tickDamage: Int
    
    init(tickDamage: Int) {
        self.effectsDescription = Strings.WeaponEffectPill.BurnStatusEffect.Description1Param.localWithArgs(tickDamage)
        self.tickDamage = tickDamage
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addStatusEffect(BurnStatusEffect(damage: self.tickDamage))
    }
    
    func getValue() -> Int {
        return 10*self.tickDamage
    }
    
}
