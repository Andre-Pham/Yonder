//
//  FullRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class FullRestorationPotion: PotionAbstract {
    
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: potionCount)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restore(for: target.maxHealth + target.getMaxArmorPoints())
        self.adjustRemainingUses(by: -1)
    }
    
}
