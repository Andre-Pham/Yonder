//
//  GrowDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

class GrowDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public let damageIncrease: Int
    
    init(damageIncrease: Int) {
        self.effectsDescription = Strings("weaponEffectPill.growDamage.description1Param").localWithArgs(damageIncrease)
        self.damageIncrease = damageIncrease
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damageIncrease = original.damageIncrease
        super.init(original)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        WeaponPillBox.getWeapon(from: self)?.adjustDamage(by: self.damageIncrease)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damageIncrease)
    }
    
}
