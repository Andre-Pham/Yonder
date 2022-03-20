//
//  DamagePotion.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class DamagePotion: PotionAbstract {
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", damage: Int, potionCount: Int, basePurchasePrice: Int) {
        super.init(name: name, description: description, remainingUses: potionCount, damage: damage, basePurchasePrice: basePurchasePrice)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
}
