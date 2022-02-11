//
//  DamagePotion.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class DamagePotion: PotionAbstract {
    
    public static let sharedID = UUID()
    public let basePurchasePrice: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", damage: Int, potionCount: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(name: name, description: description, remainingUses: potionCount, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        self.adjustRemainingUses(by: -1)
    }
    
}
