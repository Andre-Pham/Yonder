//
//  FullRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class FullRestorationPotion: PotionAbstract {
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", potionCount: Int, basePurchasePrice: Int) {
        super.init(name: name, description: description, remainingUses: potionCount, basePurchasePrice: basePurchasePrice)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restore(for: owner.maxHealth + owner.getMaxArmorPoints())
        self.adjustRemainingUses(by: -1)
    }
    
}
