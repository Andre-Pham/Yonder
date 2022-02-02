//
//  BasicWeapon.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BasicWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", damage: Int, durability: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: durability, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
}
