//
//  MaxHealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

class MaxHealthRestorationPotion: PotionAbstract {
    
    init(potionCount: Int, basePurchasePrice: Int) {
        super.init(
            name: Strings.Potion.MaxHealthRestoration.Name.local,
            description: Strings.Potion.MaxHealthRestoration.Description.local,
            effectsDescription: Strings.Potion.MaxHealthRestoration.EffectsDescription.local,
            remainingUses: potionCount,
            basePurchasePrice: basePurchasePrice)
    }
    
    required init(_ original: PotionAbstractPart) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealth(for: owner.maxHealth) // Max health - no buffs adjustment needed
        self.adjustRemainingUses(by: -1)
    }
    
}
