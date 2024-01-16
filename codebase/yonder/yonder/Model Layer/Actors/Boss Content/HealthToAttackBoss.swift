//
//  HealthToAttackBoss.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2024.
//

import Foundation

class HealthToAttackBoss: Foe {
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, conversionFraction: Double, lootChoice: LootChoice) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: DamageBasePill(damage: damage),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: [HealthToDamageEffectPill(conversionFraction: conversionFraction)]
            ),
            lootChoice: lootChoice
        )
        assert(isEqual(conversionFraction, 1.0), "The boss content (hint and description) must be updated to match the conversionFraction")
    }
    
    override func initBossContent() {
        self.setBossContent(
            hint: Strings("boss.healthToAttack.hint").local,
            description: Strings("boss.healthToAttack.description").local
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
