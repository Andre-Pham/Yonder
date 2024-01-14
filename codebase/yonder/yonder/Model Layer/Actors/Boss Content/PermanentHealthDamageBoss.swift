//
//  PermanentHealthDamageBoss.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

class PermanentHealthDamageBoss: Foe {
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, lootChoice: LootChoice) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: DamageBasePill(damage: damage),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: [PermanentDamageEffectPill()]
            ),
            lootChoice: lootChoice
        )
    }
    
    override func initBossContent() {
        self.setBossContent(
            hint: Strings("boss.permanentHealthDamage.hint").local,
            description: Strings("boss.permanentHealthDamage.description1Param").local
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
