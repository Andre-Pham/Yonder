//
//  DamageBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DamageBasePill: WeaponBasePill {
    
    private(set) var damage: Int
    public let effectsDescription: String? = nil
    
    init(damage: Int) {
        self.damage = damage
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        super.init(original)
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage)
    }
    
}
