//
//  DamageAndRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

class DamageAndRestorationBasePill: WeaponBasePill {
    
    public let damage: Int
    public let restoration: Int
    public let effectsDescription: String? = nil
    
    init(damage: Int, restoration: Int) {
        self.damage = damage
        self.restoration = restoration
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        self.restoration = original.restoration
        super.init(original)
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
        weapon.setRestoration(to: self.restoration)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage) + Pricing.playerHealthRestorationStat.getValue(amount: self.restoration)
    }
    
}
