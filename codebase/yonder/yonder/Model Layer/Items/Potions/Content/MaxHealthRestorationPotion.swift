//
//  MaxHealthRestorationPotion.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

class MaxHealthRestorationPotion: Potion {
    
    init(potionCount: Int) {
        super.init(
            name: Strings("potion.maxHealthRestoration.name").local,
            description: Strings("potion.maxHealthRestoration.description").local,
            effectsDescription: Strings("potion.maxHealthRestoration.effectsDescription").local,
            remainingUses: potionCount)
    }
    
    required init(_ original: PotionAbstract) {
        super.init(original)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        owner.restoreHealth(for: owner.maxHealth) // Max health - no buffs adjustment needed
        self.adjustRemainingUses(by: -1)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerHealthStat.baseStatAmount, uses: self.remainingUses)
    }
    
}
