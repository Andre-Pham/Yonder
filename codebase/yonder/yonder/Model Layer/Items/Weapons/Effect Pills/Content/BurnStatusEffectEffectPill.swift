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
    private let initialDuration: Int
    
    init(tickDamage: Int, duration: Int) {
        self.effectsDescription = Strings.WeaponEffectPill.BurnStatusEffect.Description1Param.localWithArgs(tickDamage)
        self.tickDamage = tickDamage
        self.initialDuration = duration
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.tickDamage = original.tickDamage
        self.initialDuration = original.initialDuration
        super.init(original)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addStatusEffect(BurnStatusEffect(damage: self.tickDamage, duration: self.initialDuration))
    }
    
    func calculateBasePurchasePrice() -> Int {
        // I'm giving a 30% discount because it's delayed
        return (Double(Pricing.playerDamageStat.getValue(amount: self.tickDamage)*self.initialDuration)*0.7).toRoundedInt()
    }
    
}
