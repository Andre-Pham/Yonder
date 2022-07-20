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
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
    }
    
    func getValue() -> Int {
        return self.damage
    }
    
}
