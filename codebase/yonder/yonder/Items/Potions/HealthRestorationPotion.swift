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
        target.restoreHealth(for: BuffApps.getAppliedHealthRestoration(owner: owner, using: self, target: target, healthRestoration: self.healthRestoration))
        self.adjustRemainingUses(by: -1)
    }
    
}
