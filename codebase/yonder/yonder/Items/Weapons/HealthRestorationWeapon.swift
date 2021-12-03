//
//  HealthRestorationWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealthRestorationWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    public let basePurchasePrice: Int

    
    init(healthRestoration: Int, durability: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(remainingUses: durability, healthRestoration: healthRestoration)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
}
