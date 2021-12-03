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
        
        super.init(remainingUses: potionCount, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
}
