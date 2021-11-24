//
//  BasicWeapon.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BasicWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    
    init(damage: Int, durability: Int) {
        super.init()
        self.damage = damage
        self.remainingUses = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
