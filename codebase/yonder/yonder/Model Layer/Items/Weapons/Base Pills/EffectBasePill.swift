//
//  EffectBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class EffectBasePill: WeaponBasePill {
    
    private(set) var durability: Int
    
    init(durability: Int) {
        self.durability = durability
    }
    
    func setup(weapon: Weapon) {
        weapon.setRemainingUses(to: self.durability)
    }
    
    func getValue() -> Int {
        return 0
    }
    
}
