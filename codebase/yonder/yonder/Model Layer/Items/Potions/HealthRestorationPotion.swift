//
//  HealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class HealthRestorationPotion: PotionAbstract {
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", healthRestoration: Int, potionCount: Int, basePurchasePrice: Int) {
        super.init(name: name, description: description, effectsDescription: "\(Term.restores.capitalized) \(healthRestoration) \(Term.health).", remainingUses: potionCount, healthRestoration: healthRestoration, basePurchasePrice: basePurchasePrice)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        self.adjustRemainingUses(by: -1)
    }
    
}
