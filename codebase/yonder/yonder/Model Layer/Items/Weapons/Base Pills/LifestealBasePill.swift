//
//  LifestealBasePill.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LifestealBasePill: WeaponBasePill, DamageSubscriber {
    
    private(set) var damage: Int
    
    init(damage: Int) {
        self.damage = damage
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
        weapon.setHealthRestoration(to: self.damage)
        weapon.addDamageSubscriber(self)
    }
    
    func getValue() -> Int {
        return self.damage*2
    }
    
    func onDamageChange(_ item: ItemAbstract, old: Int) {
        item.setHealthRestoration(to: item.damage)
    }
    
}
