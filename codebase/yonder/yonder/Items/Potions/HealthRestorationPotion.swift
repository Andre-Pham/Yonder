//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: PotionAbstract {
    
    init(healthRestoration: Int, potionCount: Int) {
        super.init()
        self.healthRestoration = healthRestoration
        self.remainingUses = potionCount
    }
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        target.restoreHealth(for: self.getAppliedHealthRestoration(owner: owner, target: target))
        self.remainingUses -= 1
    }
    
}
