//
//  ScaleAttackBoss.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

class ScaleAttackBoss: Foe {
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, damageMultiplier: Double, lootChoice: LootChoice) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: DamageBasePill(damage: damage),
                durabilityPill: InfiniteDurabilityPill(),
                effectPills: [ScaleDamageEffectPill(damageMultiplier: damageMultiplier)]
            ),
            lootChoice: lootChoice
        )
    }
    
    override func initBossContent() {
        if let pill = self.getWeapon().effectPills.first as? ScaleDamageEffectPill {
            self.setBossContent(
                hint: Strings("boss.scaleAttack.hint").local,
                description: Strings("boss.scaleAttack.description1Param").localWithArgs(pill.damageMultiplier.toRelativePercentage())
            )
        } else {
            assertionFailure("Boss based around ScaleDamageEffectPill is missing said pill, and hence description cannot be instantiated")
        }
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
