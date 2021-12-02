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
    public let basePurchasePrice: Int
    
    init(damage: Int, damageLostPerUse: Int, basePurchasePrice: Int) {
        self.damageLostPerUse = damageLostPerUse
        self.basePurchasePrice = basePurchasePrice
        
        super.init()
        self.damage = damage
        self.remainingUses = 1
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: BuffApps.getAppliedDamage(owner: owner, using: self, target: target, damage: self.damage))
        self.damage -= self.damageLostPerUse
        if self.damage <= 0 {
            self.remainingUses = 0
        }
    }
    
}
