//
//  BasicWeapon.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BasicWeapon: WeaponAbstract {
    
    init(damage: Int, durability: Int) {
        super.init()
        self.damage = damage
        self.durability = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
        self.durability -= 1
    }
    
}
