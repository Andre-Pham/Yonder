//
//  HealthRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class HealthRestorationBasePill: WeaponBasePill {
    
    private(set) var healthRestoration: Int
    private(set) var durability: Int
    
    init(healthRestoration: Int, durability: Int) {
        self.healthRestoration = healthRestoration
        self.durability = durability
    }
    
    func setup(weapon: Weapon) {
        weapon.setHealthRestoration(to: self.healthRestoration)
        weapon.setRemainingUses(to: self.durability)
    }
    
    func getValue() -> Int {
        return self.healthRestoration
    }
    
}
