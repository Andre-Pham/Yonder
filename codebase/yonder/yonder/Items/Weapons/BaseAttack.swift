//
//  BaseAttack.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BaseAttack: WeaponAbstract {
    
    public static let sharedID = UUID()
    public let basePurchasePrice = 0
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", damage: Int) {
        super.init(name: name, description: description, remainingUses: 1, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
    }
    
}
