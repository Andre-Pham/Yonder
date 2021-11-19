//
//  HealingWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealingWeapon: WeaponAbstract {
    
    init(healthRestoration: Int, durability: Int) {
        super.init()
        self.healthRestoration = healthRestoration
        self.durability = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealth(for: self.getAppliedHealthRestoration(owner: owner, target: target))
        self.durability -= 1
    }
    
}
