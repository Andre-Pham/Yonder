//
//  DullingWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class DullingWeapon: WeaponAbstract {
    
    public let damageLostPerUse: Int
    
    init(damage: Int, damageLostPerUse: Int) {
        self.damageLostPerUse = damageLostPerUse
        
        super.init()
        self.damage = damage
        self.durability = 1
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
        self.damage -= self.damageLostPerUse
        if self.damage <= 0 {
            self.durability = 0
        }
    }
    
}
