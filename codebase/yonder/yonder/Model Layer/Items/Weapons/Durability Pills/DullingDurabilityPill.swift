//
//  DullingDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DullingDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String
    public let damageLostPerUse: Int
    
    init(damageLostPerUse: Int) {
        self.effectsDescription = Strings.WeaponDurabilityPill.Dulling.Description1Param.localWithArgs(damageLostPerUse)
        self.damageLostPerUse = damageLostPerUse
    }
    
    func setupDurability(weapon: Weapon) {
        weapon.setRemainingUses(to: 1)
        weapon.setInfiniteRemainingUses(to: true)
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
