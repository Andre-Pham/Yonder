//
//  BaseAttack.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BaseAttack: WeaponAbstract {
    
    init(damage: Int) {
        super.init()
        self.damage = damage
        self.durability = 1
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.appliedDamage)
    }
    
}
