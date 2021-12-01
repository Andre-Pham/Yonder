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
    public let purchaseType: PurchasableType = .weapon
    
    init(healthRestoration: Int, durability: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init()
        self.healthRestoration = healthRestoration
        self.remainingUses = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealth(for: self.getAppliedHealthRestoration(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
