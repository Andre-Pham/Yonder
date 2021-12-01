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
    public let purchaseType: PurchasableType = .weapon
    
    init(damage: Int) {
        super.init()
        self.damage = damage
        self.remainingUses = 1
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: self.getAppliedDamage(owner: owner, target: target))
    }
    
}
