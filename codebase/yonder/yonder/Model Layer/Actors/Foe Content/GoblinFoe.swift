//
//  GoblinFoe.swift
//  yonder
//
//  Created by Andre Pham on 7/11/2022.
//

import Foundation

class GoblinFoe: Foe {
    
    init(name: String, description: String, maxHealth: Int, goldPerSteal: Int, damage: Int, loot: LootOptions) {
        super.init(
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: EffectBasePill(),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: [GoblinEffectPill(goldPerSteal: goldPerSteal, damage: damage)]
            ),
            loot: loot
        )
    }
    
}
