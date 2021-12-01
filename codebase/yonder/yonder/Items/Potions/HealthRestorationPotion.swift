//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: PotionAbstract {
    
    public let basePurchasePrice: Int
    public let purchaseType: PurchasableType = .potion
    
    init(healthRestoration: Int, potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init()
        self.healthRestoration = healthRestoration
        self.remainingUses = potionCount
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealth(for: self.getAppliedHealthRestoration(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
