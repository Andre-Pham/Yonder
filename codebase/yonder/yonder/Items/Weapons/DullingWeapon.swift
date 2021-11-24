//
//  DullingWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class DullingWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    public let damageLostPerUse: Int
    
    init(damage: Int, damageLostPerUse: Int) {
        self.damageLostPerUse = damageLostPerUse
        
        super.init()
        self.damage = damage
        self.remainingUses = 1
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
        self.damage -= self.damageLostPerUse
        if self.damage <= 0 {
            self.remainingUses = 0
        }
    }
    
}
