//
//  WoodenSwordWeapon.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class WoodenSword: WeaponAbstract {
    
    init(damage: Int, durability: Int) {
        super.init()
        self.damage = damage
        self.durability = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.appliedDamage)
        self.durability -= 1
    }
    
}
