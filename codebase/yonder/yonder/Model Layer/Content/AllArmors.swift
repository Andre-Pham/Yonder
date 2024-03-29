//
//  AllArmors.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

enum Armors {
    
    // 01
    static func regularArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 40, max: 110)
        let armorPoints = armorPointsRange.select(stage: stage)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [],
            equipmentPills: []
        )
    }
    
    
    // 02
    static func damagePercentArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 25, max: 70)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageFraction = Random.selectFromLinearDistribution(min: 1.05, max: 1.2, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: damageFraction
                )
            ],
            equipmentPills: []
        )
    }
    
    // 03
    static func highDamagePercentArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 10, max: 50)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageFraction = Random.selectFromLinearDistribution(min: 1.15, max: 1.5, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: damageFraction
                )
            ],
            equipmentPills: []
        )
    }
    
    // 04
    static func damageArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 25, max: 70)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageBonusRange = StatRange(min: 5, max: 25)
        damageBonusRange.compound(multiply: 1.2, index: stage)
        let damageBonus = damageBonusRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamageBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageDifference: damageBonus
                )
            ],
            equipmentPills: []
        )
    }
    
    // 05
    static func highDamageArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 10, max: 50)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageBonusRange = StatRange(min: 30, max: 60)
        damageBonusRange.compound(multiply: 1.2, index: stage)
        let damageBonus = damageBonusRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamageBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageDifference: damageBonus
                )
            ],
            equipmentPills: []
        )
    }
    
    // 06
    static func resistanceArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 30, max: 90)
        let armorPoints = armorPointsRange.select(stage: stage)
        let resistance = Random.selectFromLinearDistribution(min: 0.7, max: 0.95, minY: 1, maxY: 10)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: resistance
                )
            ],
            equipmentPills: []
        )
    }
    
    // 07
    static func highResistanceArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 20, max: 65)
        let armorPoints = armorPointsRange.select(stage: stage)
        let resistance = Random.selectFromLinearDistribution(min: 0.6, max: 0.8, minY: 1, maxY: 10)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: resistance
                )
            ],
            equipmentPills: []
        )
    }
    
    // 08
    static func damageNegationArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 25, max: 70)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageNegationRange = StatRange(min: 5, max: 20)
        damageNegationRange.compound(multiply: 1.2, index: stage)
        let damageNegation = damageNegationRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamageBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageDifference: -damageNegation
                )
            ],
            equipmentPills: []
        )
    }
    
    // 09
    static func highDamageNegationArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 15, max: 60)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageNegationRange = StatRange(min: 20, max: 35)
        damageNegationRange.compound(multiply: 1.2, index: stage)
        let damageNegation = damageNegationRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamageBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageDifference: -damageNegation
                )
            ],
            equipmentPills: []
        )
    }
    
    // 10
    static func thornsArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 35, max: 100)
        let armorPoints = armorPointsRange.select(stage: stage)
        let thornsFraction = Random.selectFromLinearDistribution(min: 0.05, max: 0.25, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [],
            equipmentPills: [
                ThornsEquipmentPill(thornsFraction: thornsFraction, sourceName: profile.armorName)
            ]
        )
    }
    
    // 11
    static func restorationPercentArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 35, max: 100)
        let armorPoints = armorPointsRange.select(stage: stage)
        let restorationPercent = Random.selectFromLinearDistribution(min: 1.1, max: 1.5, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                HealthRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: restorationPercent
                ),
                ArmorPointsRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsFraction: restorationPercent
                )
            ],
            equipmentPills: []
        )
    }
    
    // 12
    static func thornsAndResistanceArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 25, max: 80)
        let armorPoints = armorPointsRange.select(stage: stage)
        let resistance = Random.selectFromLinearDistribution(min: 0.8, max: 0.95, minY: 1, maxY: 10)
        let thornsFraction = Random.selectFromLinearDistribution(min: 0.05, max: 0.15, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: resistance
                )
            ],
            equipmentPills: [
                ThornsEquipmentPill(thornsFraction: thornsFraction, sourceName: profile.armorName)
            ]
        )
    }
    
    // 13
    static func bitOfEverythingArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 20, max: 55)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageFraction = Random.selectFromLinearDistribution(min: 1.05, max: 1.15, minY: 20, maxY: 1)
        let resistance = Random.selectFromLinearDistribution(min: 0.85, max: 0.95, minY: 1, maxY: 20)
        let thornsFraction = Random.selectFromLinearDistribution(min: 0.05, max: 0.1, minY: 20, maxY: 1)
        let armorRestorationFraction = Random.selectFromLinearDistribution(min: 1.05, max: 1.15, minY: 20, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: resistance
                ),
                DamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: damageFraction
                ),
                ArmorPointsRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsFraction: armorRestorationFraction
                )
            ],
            equipmentPills: [
                ThornsEquipmentPill(thornsFraction: thornsFraction, sourceName: profile.armorName)
            ]
        )
    }
    
    // 14
    static func phoenixArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 35, max: 100)
        let armorPoints = armorPointsRange.select(stage: stage)
        var healthSetTo: Int? = nil
        if Random.roll(4, in: 5) {
            healthSetTo = Random.selectFromNormalDistribution(min: 50, max: 200).nearest(10)
        }
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [],
            equipmentPills: [
                PhoenixEquipmentPill(healthSetTo: healthSetTo, sourceName: profile.armorName)
            ]
        )
    }
    
    // 15
    static func alchemistArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        let armorPointsRange = ArmorPointsRange(type: type, min: 35, max: 75)
        let armorPoints = armorPointsRange.select(stage: stage)
        let damageFraction = Random.selectFromLinearDistribution(min: 1.5, max: 2.0, minY: 10, maxY: 1)
        let healthRestorationFraction = Random.selectFromLinearDistribution(min: 1.5, max: 2.0, minY: 10, maxY: 1)
        let consumableArmorPointsRestorationFraction = Random.selectFromLinearDistribution(min: 1.2, max: 1.8, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                PotionDamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: damageFraction
                ),
                PotionHealthRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: healthRestorationFraction
                ),
                ConsumableArmorPointsRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsFraction: consumableArmorPointsRestorationFraction
                )
            ],
            equipmentPills: []
        )
    }
    
    // 16
    static func bladeMasterArmor(profile: ArmorProfile, stage: Int, type: ArmorType) -> Armor {
        // Stronger weapons, weaker potions
        let armorPointsRange = ArmorPointsRange(type: type, min: 35, max: 75)
        let armorPoints = armorPointsRange.select(stage: stage)
        let weaponDamageFraction = Random.selectFromLinearDistribution(min: 1.2, max: 1.6, minY: 10, maxY: 1)
        let weaponHealthRestorationFraction = Random.selectFromLinearDistribution(min: 1.4, max: 1.8, minY: 10, maxY: 1)
        let weaponArmorPointsRestorationFraction = Random.selectFromLinearDistribution(min: 1.2, max: 1.5, minY: 10, maxY: 1)
        let potionDamageFraction = Random.selectFromLinearDistribution(min: 0.3, max: 0.6, minY: 10, maxY: 1)
        let potionHealthRestorationFraction = Random.selectFromLinearDistribution(min: 0.4, max: 0.8, minY: 10, maxY: 1)
        return Armor(
            name: profile.armorName,
            description: "",
            type: type,
            armorPoints: armorPoints,
            armorBuffs: [
                WeaponDamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: weaponDamageFraction
                ),
                WeaponHealthRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: weaponHealthRestorationFraction
                ),
                WeaponArmorPointsRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsFraction: weaponArmorPointsRestorationFraction
                ),
                PotionDamagePercentBuff(
                    sourceName: profile.armorName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: potionDamageFraction
                ),
                PotionHealthRestorationPercentBuff(
                    sourceName: profile.armorName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: potionHealthRestorationFraction
                )
            ],
            equipmentPills: []
        )
    }
    
}

fileprivate class ArmorPointsRange: StatRange {
    
    init(type: ArmorType, min: Int, max: Int) {
        var min = Double(min)
        var max = Double(max)
        switch type {
        case .head:
            min *= 0.6
            max *= 0.6
        case .body:
            min *= 1.4
            max *= 1.4
        case .legs:
            break
        }
        super.init(min: min, max: max)
    }
    
    func select(stage: Int, minY: Double = 10, maxY: Double = 1) -> Int {
        self.compound(multiply: 1.5, index: stage)
        return self.selectFromLinearDistribution(minY: minY, maxY: maxY).toRoundedInt().nearest(5)
    }
    
}
