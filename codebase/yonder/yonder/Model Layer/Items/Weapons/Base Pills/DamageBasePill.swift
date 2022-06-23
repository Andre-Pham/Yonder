//
//  DamageBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DamageBasePill: WeaponBasePill {
    
    private(set) var damage: Int
    private(set) var durability: Int
    
    init(damage: Int, durability: Int) {
        self.damage = damage
        self.durability = durability
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
        weapon.setRemainingUses(to: self.durability)
    }
    
    func getValue() -> Int {
        return self.damage
    }
    
}
