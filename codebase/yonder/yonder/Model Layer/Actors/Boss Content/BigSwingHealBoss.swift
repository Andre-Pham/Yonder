//
//  BigSwingHealBoss.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

class BigSwingHealBoss: Foe {
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damagesToCycleThrough: [Int], lootChoice: LootChoice) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: EffectBasePill(),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: [CycleDamageEffectPill(damagesToCycleThrough: damagesToCycleThrough), HealthLifestealEffectPill(lifestealFraction: 1.0)]
            ),
            lootChoice: lootChoice
        )
        
        // The purpose of this boss is that every 3rd attack is a massive swing
        // (Also they heal from any health damage dealt)
        // Hence we need to check that the descriptions provided for this boss match the parameters provided
        assert(damagesToCycleThrough.count == 3, "The boss content (hint and description) must be updated to match the damages")
        assert(damagesToCycleThrough[0] == damagesToCycleThrough[1], "The boss content (hint and description) must be updated to match the damages")
        assert(damagesToCycleThrough[1] < damagesToCycleThrough[2], "The boss content (hint and description) must be updated to match the damages")
    }
    
    override func initBossContent() {
        self.setBossContent(
            hint: Strings("boss.bigSwingHeal.hint").local,
            description: Strings("boss.bigSwingHeal.description").local
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
