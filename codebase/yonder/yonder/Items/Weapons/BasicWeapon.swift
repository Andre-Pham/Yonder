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
        
        super.init()
        self.damage = damage
        self.remainingUses = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
