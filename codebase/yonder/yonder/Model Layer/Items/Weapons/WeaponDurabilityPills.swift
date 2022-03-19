//
//  WeaponDurabilityPills.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

class DecrementDurabilityPill: WeaponDurabilityPill {
    
    let decrementation: Int
    
    init(decrementBy amount: Int = 1) {
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
    
    let damageLostPerUse: Int
    
    init(damageLostPerUse: Int) {
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
    
    func use(on weapon: Weapon) {
        // Do nothing - weapon has infinite durability
    }

    func getValue() -> Int {
        return 500
    }
    
}

