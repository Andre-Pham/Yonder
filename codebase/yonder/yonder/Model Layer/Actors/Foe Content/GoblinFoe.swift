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
    
    override func initFoeType() {
        self.setType(
            name: Strings("foeType.goblin.name").local,
            description: Strings("foeType.goblin.description").local,
            imageResource: YonderImages.goblinIcon
        )
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
