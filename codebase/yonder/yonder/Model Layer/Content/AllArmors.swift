//
//  AllArmors.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

enum Armors {
    
    // MARK: - Resistance Armor
    
    // Test armor set
    static func newTestHeadArmor() -> ArmorAbstract {
        return ArmorAbstract(name: "Resistance Armor", description: "Very resistive.", type: .head, armorPoints: 200, basePurchasePrice: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    static func newTestBodyArmor() -> ArmorAbstract {
        return ArmorAbstract(name: "Resistance Armor", description: "Very resistive.", type: .body, armorPoints: 200, basePurchasePrice: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    static func newTestLegsArmor() -> ArmorAbstract {
        return ArmorAbstract(name: "Resistance Armor", description: "Very resistive.", type: .legs, armorPoints: 200, basePurchasePrice: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
}
