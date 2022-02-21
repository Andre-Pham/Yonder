//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: PotionAbstract {
    
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", healthRestoration: Int, potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: potionCount, healthRestoration: healthRestoration)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
}
