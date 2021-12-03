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
    
    init(damage: Int) {
        super.init(remainingUses: 1, damage: damage)
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.damage(for: BuffApps.getAppliedDamage(owner: owner, using: self, target: target, damage: self.damage))
    }
    
}
