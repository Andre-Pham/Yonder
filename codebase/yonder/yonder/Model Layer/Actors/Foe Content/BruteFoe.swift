//
//  BruteFoe.swift
//  yonder
//
//  Created by Andre Pham on 7/11/2022.
//

import Foundation

class BruteFoe: Foe {
    
    private var buffPill: ArmorDamagePercentBuffPill {
        self.getWeapon().buffPills.first as! ArmorDamagePercentBuffPill
    }
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, loot: LootOptions) {
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: Weapon(
                basePill: DamageBasePill(damage: damage),
                durabilityPill: InfiniteDurabilityPill(),
                buffPills: [ArmorDamagePercentBuffPill(damageFraction: 2.0)]
            ),
            loot: loot
        )
        self.addBuff(BuffProxy(
            sourceName: Strings("foeType.brute.buffName").local,
            effectsDescription: self.buffPill.effectsDescription,
            type: .damage,
            direction: .outgoing
        ))
    }
    
    override func initFoeType() {
        let damageFraction = self.buffPill.damageFraction
        self.setType(
            name: Strings("foeType.brute.name").local,
            description: Strings("foeType.brute.description1Param").localWithArgs(damageFraction.toString(decimalPlaces: 0)),
            imageResource: YonderImages.bruteIcon
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
