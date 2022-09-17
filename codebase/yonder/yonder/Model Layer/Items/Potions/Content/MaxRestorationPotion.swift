//
//  MaxRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class MaxRestorationPotion: Potion {
    
    init(potionCount: Int, basePurchasePrice: Int) {
        super.init(
            name: Strings.Potion.MaxRestoration.Name.local,
            description: Strings.Potion.MaxRestoration.Description.local,
            effectsDescription: Strings.Potion.MaxRestoration.EffectsDescription.local,
            remainingUses: potionCount,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restore(for: owner.maxHealth + owner.maxArmorPoints) // Max stats - no buffs adjustment needed
        self.adjustRemainingUses(by: -1)
    }
    
}
