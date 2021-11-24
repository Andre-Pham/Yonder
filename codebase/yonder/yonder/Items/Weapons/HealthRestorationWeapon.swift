//
//  HealthRestorationWeapon.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealthRestorationWeapon: WeaponAbstract {
    
    public static let sharedID = UUID()
    
    init(healthRestoration: Int, durability: Int) {
        super.init()
        self.healthRestoration = healthRestoration
        self.remainingUses = durability
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealth(for: self.getAppliedHealthRestoration(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
