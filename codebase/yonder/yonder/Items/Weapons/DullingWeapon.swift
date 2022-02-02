//
//  DullingWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class DullingWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    public let damageLostPerUse: Int
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", damage: Int, damageLostPerUse: Int, basePurchasePrice: Int) {
        self.damageLostPerUse = damageLostPerUse
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: 1, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustDamage(by: -self.damageLostPerUse)
        if self.damage <= 0 {
            self.setRemainingUses(to: 0)
        }
    }
    
}
