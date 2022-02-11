//
//  WeaponBasePills.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

class DamageBasePill: WeaponBasePill {
    
    var type: WeaponType = .damage
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

class HealthRestorationBasePill: WeaponBasePill {
    
    var type: WeaponType = .healthRestoration
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

class EffectBasePill: WeaponBasePill {
    
    var type: WeaponType = .effect
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
