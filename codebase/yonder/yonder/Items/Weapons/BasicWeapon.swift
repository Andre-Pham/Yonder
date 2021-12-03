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
    
    init(damage: Int, durability: Int, basePurchasePrice: Int) {
        self.basePurchasePrice = basePurchasePrice
        
        super.init(remainingUses: durability, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: BuffApps.getAppliedDamage(owner: owner, using: self, target: target, damage: self.damage))
        self.adjustRemainingUses(by: -1)
    }
    
}
