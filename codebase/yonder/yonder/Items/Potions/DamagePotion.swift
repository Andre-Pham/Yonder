//
//  DamagePotion.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class DamagePotion: PotionAbstract {
    
    public let basePurchasePrice: Int
    
    init(damage: Int, potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init()
        self.damage = damage
        self.remainingUses = potionCount
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: BuffApps.getAppliedDamage(owner: owner, using: self, target: target, damage: self.damage))
        self.remainingUses -= 1
    }
    
}
