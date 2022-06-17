//
//  WeaponDurabilityPills.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

class DecrementDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String
    public let decrementation: Int
    
    init(decrementBy amount: Int = 1) {
        self.effectsDescription = Strings.WeaponDurabilityPill.Decrement.Description1Param.localWithArgs(amount)
        self.decrementation = -amount
    }
    
    func use(on weapon: Weapon) {
        weapon.adjustRemainingUses(by: self.decrementation)
    }
    
    func getValue() -> Int {
        return 0
    }
    
}

class DullingDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String
    public let damageLostPerUse: Int
    
    init(damageLostPerUse: Int) {
        self.effectsDescription = Strings.WeaponDurabilityPill.Dulling.Description1Param.localWithArgs(damageLostPerUse)
        self.damageLostPerUse = damageLostPerUse
    }
    
    func use(on weapon: Weapon) {
        weapon.adjustDamage(by: -self.damageLostPerUse)
        if weapon.damage <= 0 {
            weapon.setRemainingUses(to: 0)
        }
    }
    
    func getValue() -> Int {
        return 0
    }
    
}

class InfiniteDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String = Strings.WeaponDurabilityPill.Infinite.Description.local
    
    func use(on weapon: Weapon) {
        // Do nothing - weapon has infinite durability
    }

    func getValue() -> Int {
        return 500
    }
    
}

