//
//  AllArmors.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

enum Armors {
    
    // TODO: Remove
    static func newTestHeadArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .head, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    // TODO: Remove
    static func newTestBodyArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .body, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    // TODO: Remove
    static func newTestLegsArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .legs, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    static func regularArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let targetArmorPoints = 100.0.compound(multiply: 1.5, index: stage).toRoundedInt()
        let armorPoints = Random.selectFromNormalDistribution(mid: targetArmorPoints, boundFraction: 0.25).nearest(5)
        return Armor(
            name: profile.armorName,
            description: profile.armorDescription,
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [],
            equipmentPills: []
        )
    }
    
}
