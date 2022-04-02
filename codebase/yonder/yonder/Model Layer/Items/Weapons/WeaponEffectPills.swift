//
//  WeaponEffectPills.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

class BurnStatusEffectEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public var priority: WeaponEffectPillPriority = .first
    public let tickDamage: Int
    
    init(tickDamage: Int) {
        self.effectsDescription = "Burns the opposing \(Term.foe) \(tickDamage) \(Term.damage) every \(Term.use)"
        self.tickDamage = tickDamage
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addStatusEffect(BurnStatusEffect(damage: self.tickDamage))
    }
    
    func getValue() -> Int {
        return 10*self.tickDamage
    }
    
}
