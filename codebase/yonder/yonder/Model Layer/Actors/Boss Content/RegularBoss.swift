//
//  RegularBoss.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

class RegularBoss: Foe {
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, lootChoice: LootChoice) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: DamageBasePill(damage: damage),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: []
            ),
            lootChoice: lootChoice
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
