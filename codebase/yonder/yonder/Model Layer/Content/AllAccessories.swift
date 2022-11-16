//
//  AllAccessories.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

enum Accessories {
    
    static func resistanceAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let resistanceRange = Range(type: type, regular: (0.95, 0.75), peripheral: (0.75, 0.5))
        let damageFractionPercent = resistanceRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamagePercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: damageFractionPercent
                )
            ],
            equipmentPills: []
        )
    }
    
    static func reduceDamageAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let damageRange = Range(type: type, regular: (5, 25), peripheral: (25, 50))
        let damage = damageRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamageBuff(sourceName: profile.accessoryName, direction: .incoming, duration: nil, damageDifference: -damage)
            ],
            equipmentPills: []
        )
    }
    
    static func weaponLifestealAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let lifestealRange = Range(type: type, regular: (0.05, 0.25), peripheral: (0.25, 0.5))
        let lifestealFraction = lifestealRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        let pill = WeaponLifestealEquipmentPill(lifestealFraction: lifestealFraction, sourceName: profile.accessoryName)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [pill]
        )
    }
    
    static func bonusHitPointsAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let healthRange = Range(type: type, regular: (50, 150), peripheral: (150, 300))
        healthRange.compound(multiply: 1.2, index: stage)
        let armorPointsRange = Range(type: type, regular: (50, 150), peripheral: (150, 300))
        armorPointsRange.compound(multiply: 1.5, index: stage)
        let health = healthRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt().nearest(10)
        let armorPoints = armorPointsRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt().nearest(10)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: health,
            armorPointsBonus: armorPoints,
            buffs: [],
            equipmentPills: []
        )
    }
    
    static func phoenixAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let healthSetTo = (type == .regular ? 50 : nil)
        let pill = PhoenixEquipmentPill(healthSetTo: healthSetTo, sourceName: profile.accessoryName)
        let healthBonus = Int.random(in: 0...150).nearest(50)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: healthBonus,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [pill]
        )
    }
    
    static func tankAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let healthRange = Range(type: type, regular: (25, 75), peripheral: (75, 150))
        healthRange.compound(multiply: 1.2, index: stage)
        let armorPointsRange = Range(type: type, regular: (25, 75), peripheral: (75, 150))
        armorPointsRange.compound(multiply: 1.5, index: stage)
        let health = healthRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        let armorPoints = armorPointsRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        let resistanceRange = Range(type: type, regular: (0.95, 0.85), peripheral: (0.85, 0.7))
        let damageFractionPercent = resistanceRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: health,
            armorPointsBonus: armorPoints,
            buffs: [
                DamagePercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: damageFractionPercent
                )
            ],
            equipmentPills: []
        )
    }
    
    static func damageBuffAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let damageRange = Range(type: type, regular: (1.05, 1.25), peripheral: (1.25, 1.5))
        let damagePercent = damageRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamagePercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: damagePercent
                )
            ],
            equipmentPills: []
        )
    }
    
    static func bonusDamageAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let damageRange = Range(type: type, regular: (5, 25), peripheral: (25, 50))
        let damage = damageRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamageBuff(sourceName: profile.accessoryName, direction: .outgoing, duration: nil, damageDifference: damage)
            ],
            equipmentPills: []
        )
    }
    
    static func healthRestorationBuffAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let healthRestorationRange = Range(type: type, regular: (1.15, 1.4), peripheral: (1.4, 1.8))
        let healthRestorationPercent = healthRestorationRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                HealthRestorationPercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: healthRestorationPercent
                )
            ],
            equipmentPills: []
        )
    }
    
    static func bonusHealthRestorationAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let healthRange = Range(type: type, regular: (15, 40), peripheral: (40, 100))
        let health = healthRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                HealthRestorationBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    healthDifference: health
                )
            ],
            equipmentPills: []
        )
    }
    
    static func armorPointsRestorationBuffAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let armorPointsRange = Range(type: type, regular: (1.05, 1.25), peripheral: (1.25, 1.5))
        let armorPointsPercent = armorPointsRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                ArmorPointsRestorationPercentBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsFraction: armorPointsPercent
                )
            ],
            equipmentPills: []
        )
    }
    
    static func bonusArmorPointsRestorationAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let armorPointsRange = Range(type: type, regular: (10, 35), peripheral: (35, 70))
        let armorPoints = armorPointsRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                ArmorPointsRestorationBuff(
                    sourceName: profile.accessoryName,
                    direction: .incoming,
                    duration: nil,
                    armorPointsDifference: armorPoints
                )
            ],
            equipmentPills: []
        )
    }
    
    static func thornsAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let thornsRange = Range(type: type, regular: (0.05, 0.25), peripheral: (0.25, 0.5))
        let thorns = thornsRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        let pill = ThornsEquipmentPill(thornsFraction: thorns, sourceName: profile.accessoryName)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [pill]
        )
    }
    
    static func priceBuffAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let priceRange = Range(type: type, regular: (0.95, 0.75), peripheral: (0.75, 0.5))
        let pricePercent = priceRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                PricePercentBuff(sourceName: profile.accessoryName, duration: nil, priceFraction: pricePercent)
            ],
            equipmentPills: []
        )
    }
    
    static func reducedPriceAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let priceRange = Range(type: type, regular: (10, 50), peripheral: (50, 100))
        let price = priceRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                PriceBuff(sourceName: profile.accessoryName, duration: nil, priceDifference: -price)
            ],
            equipmentPills: []
        )
    }
    
    static func goldBuffAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let goldRange = Range(type: type, regular: (1.05, 1.25), peripheral: (1.25, 1.5))
        let goldPercent = goldRange.selectFromLinearDistribution(minY: 10, maxY: 1)
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                GoldPercentBuff(sourceName: profile.accessoryName, duration: nil, goldFraction: goldPercent)
            ],
            equipmentPills: []
        )
    }
    
    static func bonusGoldAccessory(profile: AccessoryProfile, stage: Int, type: AccessoryType) -> Accessory {
        let goldRange = Range(type: type, regular: (50, 100), peripheral: (100, 200))
        let gold = goldRange.selectFromLinearDistribution(minY: 10, maxY: 1).toRoundedInt()
        return Accessory(
            name: profile.accessoryName,
            description: profile.accessoryDescription,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                GoldBuff(sourceName: profile.accessoryName, duration: nil, goldDifference: gold)
            ],
            equipmentPills: []
        )
    }
    
}

fileprivate class Range {
    
    private(set) var min: Double
    var minInt: Int { self.min.toRoundedInt() }
    private(set) var max: Double
    var maxInt: Int { self.max.toRoundedInt() }
    
    init(type: AccessoryType, regular: (Double, Double), peripheral: (Double, Double)) {
        self.min = (type == .regular ? regular.0 : peripheral.0)
        self.max = (type == .regular ? regular.1 : peripheral.1)
    }
    
    init(type: AccessoryType, regular: (Int, Int), peripheral: (Int, Int)) {
        self.min = Double(type == .regular ? regular.0 : peripheral.0)
        self.max = Double(type == .regular ? regular.1 : peripheral.1)
    }
    
    func compound(multiply: Double, index: Int) {
        self.min = self.min.compound(multiply: multiply, index: index)
        self.max = self.max.compound(multiply: multiply, index: index)
    }
    
    func selectFromLinearDistribution(minY: Double, maxY: Double) -> Double {
        return Random.selectFromLinearDistribution(min: self.min, max: self.max, minY: minY, maxY: maxY)
    }
    
}
