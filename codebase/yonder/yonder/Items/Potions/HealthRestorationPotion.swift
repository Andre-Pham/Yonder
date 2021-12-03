//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: PotionAbstract {
    
    public let basePurchasePrice: Int
    
    init(healthRestoration: Int, potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(remainingUses: potionCount, healthRestoration: healthRestoration)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
}
