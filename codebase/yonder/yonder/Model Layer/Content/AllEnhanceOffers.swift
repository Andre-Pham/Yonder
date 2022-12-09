//
//  AllEnhanceOffers.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

enum EnhanceOffers {
    
    // 01
    static func damageForWeapon(stage: Int) -> EnhanceOffer {
        let damage = Random.selectFromNormalDistribution(min: 10.0, max: 30.0).compound(multiply: 1.3, index: stage).toRoundedInt().nearest(5)
        let priceTarget = Pricing.usingStage(stage: stage) {
            Pricing.playerDamageStat.getValue(amount: damage, uses: 5)
        }
        let price = Random.selectFromNormalDistribution(mid: priceTarget, boundFraction: 0.3)
        return WeaponDamageEnhanceOffer(price: price, damage: damage)
    }
    
    // 02
    static func lifestealForWeapon(stage: Int) -> EnhanceOffer {
        let fraction = Random.selectFromLinearDistribution(min: 0.5, max: 1.0, minY: 50, maxY: 10).nearest(0.1)
        let effectPill = LifestealEffectPill(lifestealFraction: fraction)
        let priceTarget = Pricing.usingStage(stage: stage) { effectPill.calculateBasePurchasePrice() }
        let price = Random.selectFromNormalDistribution(mid: priceTarget, boundFraction: 0.3)
        return WeaponEffectEnhanceOffer(price: price, effectPill: effectPill)
    }
    
    // 03
    static func burnForWeapon(stage: Int) -> EnhanceOffer {
        let tickDamageRange = StatRange(target: 40, boundFraction: 0.5)
        tickDamageRange.compound(multiply: 1.2, index: stage)
        let tickDamage: Int = tickDamageRange.selectFromNormalDistribution()
        let duration = Random.selectFromNormalDistribution(min: 3, max: 6)
        let burnPill = BurnStatusEffectEffectPill(tickDamage: tickDamage, duration: duration)
        let priceRange = StatRange(target: burnPill.calculateBasePurchasePrice(), boundFraction: 0.4)
        let price: Int = priceRange.selectFromNormalDistribution()
        return WeaponEffectEnhanceOffer(price: price, effectPill: burnPill)
    }

    // 04
    static func durabilityForWeapon(stage: Int) -> EnhanceOffer {
        // Assume a weapon that just does damage, just for a ballpark figure to evaluate the value of a durability
        let durability = Int.random(in: 3...5)
        let priceTarget = Pricing.usingStage(stage: stage) {
            let expectedDamage = Pricing.playerDamageStat.baseStatAmount
            return Pricing.playerDamageStat.getValue(amount: expectedDamage, uses: durability)
        }
        let price: Int = StatRange(target: priceTarget, boundFraction: 0.3).selectFromNormalDistribution()
        return WeaponDurabilityEnhanceOffer(price: price, amount: durability)
    }

    // 05
    static func growDamageForWeapon(stage: Int) -> EnhanceOffer {
        let damageIncrease: Int = StatRange(min: 20, max: 50)
            .compound(multiply: 1.2, index: stage)
            .selectFromNormalDistribution()
        let growPill = GrowDamageEffectPill(damageIncrease: damageIncrease)
        let price = Random.selectFromNormalDistribution(
            mid: growPill.calculateBasePurchasePrice(),
            boundFraction: 0.4
        )
        return WeaponEffectEnhanceOffer(price: price, effectPill: growPill)
    }

    // 06
    static func resistanceForArmor(stage: Int) -> EnhanceOffer {
        let resistance = Random.selectFromLinearDistribution(min: 0.6, max: 0.9, minY: 1, maxY: 10)
        let buff = DamagePercentBuff(sourceName: Strings("enhanceOffer.source").local, direction: .incoming, duration: nil, damageFraction: resistance)
        let price = Random.selectFromNormalDistribution(
            mid: buff.getValue(whenTargeting: .player),
            boundFraction: 0.2
        )
        return ArmorBuffEnhanceOffer(price: price, buff: buff)
    }

    // 07
    static func damagePercentForArmor(stage: Int) -> EnhanceOffer {
        let damagePercent = Random.selectFromLinearDistribution(min: 1.1, max: 1.4, minY: 10, maxY: 1)
        let buff = DamagePercentBuff(sourceName: Strings("enhanceOffer.source").local, direction: .outgoing, duration: nil, damageFraction: damagePercent)
        let price = Random.selectFromNormalDistribution(
            mid: buff.getValue(whenTargeting: .player),
            boundFraction: 0.2
        )
        return ArmorBuffEnhanceOffer(price: price, buff: buff)
    }

    // 08
    static func armorPointsForArmor(stage: Int) -> EnhanceOffer {
        let amount = 10.0.compound(multiply: 1.5, index: stage).toRoundedInt().nearest(5)
        let price = Random.selectFromNormalDistribution(
            mid: Pricing.playerArmorPointsStat.getValue(amount: amount),
            boundFraction: 0.3
        )
        return ArmorPointsEnhanceOffer(price: price, armorPoints: amount)
    }

    // 09
    static func thornsForArmor(stage: Int) -> EnhanceOffer {
        let thornsFraction = Random.selectFromLinearDistribution(min: 0.1, max: 0.5, minY: 10, maxY: 1)
        let thornsPill = ThornsEquipmentPill(thornsFraction: thornsFraction, sourceName: Strings("enhanceOffer.source").local)
        let price = Random.selectFromNormalDistribution(
            mid: thornsPill.getValue(whenTargeting: .player),
            boundFraction: 0.3
        )
        return ArmorEquipmentPillEnhanceOffer(price: price, pill: thornsPill)
    }

    // 10
    static func bonusHealthForAccessory(stage: Int) -> EnhanceOffer {
        let amount = 10.0.compound(multiply: 1.2, index: stage).toRoundedInt().nearest(5)
        let price = Random.selectFromNormalDistribution(
            mid: Pricing.playerHealthStat.getValue(amount: amount),
            boundFraction: 0.3
        )
        return AccessoryHealthEnhanceOffer(price: price, health: amount)
    }

    // 11
    static func phoenixForEquipment(stage: Int) -> EnhanceOffer {
        let healsToFull = Random.roll(1, in: 3)
        var healthToSetTo: Int? = nil
        if !healsToFull {
            healthToSetTo = Int.random(in: 0...200).nearest(50)
        }
        let pill = PhoenixEquipmentPill(healthSetTo: healthToSetTo, sourceName: Strings("enhanceOffer.source").local)
        let price = Random.selectFromNormalDistribution(
            mid: pill.getValue(whenTargeting: .player),
            boundFraction: 0.3
        )
        return EquipmentPillEnhanceOffer(price: price, pill: pill)
    }

    // 12
    static func doubleHealthRestorationForWeapon(stage: Int) -> EnhanceOffer {
        let priceTarget = Pricing.usingStage(stage: stage) {
            let amount = Pricing.playerHealthRestorationStat.baseStatAmount
            return Pricing.playerHealthRestorationStat.getValue(amount: amount, uses: 3)
        }
        let price = Random.selectFromNormalDistribution(
            mid: priceTarget,
            boundFraction: 0.5
        )
        return DoubleWeaponHealthRestorationEnhanceOffer(price: price)
    }

    // 13
    static func doubleArmorPointsRestorationForWeapon(stage: Int) -> EnhanceOffer {
        let priceTarget = Pricing.usingStage(stage: stage) {
            let amount = Pricing.playerArmorPointsRestorationStat.baseStatAmount
            return Pricing.playerArmorPointsRestorationStat.getValue(amount: amount, uses: 3)
        }
        let price = Random.selectFromNormalDistribution(
            mid: priceTarget,
            boundFraction: 0.5
        )
        return DoubleWeaponArmorPointsRestorationEnhanceOffer(price: price)
    }

    // 14
    static func goldPercentBuffForAccessory(stage: Int) -> EnhanceOffer {
        let goldFraction = Random.selectFromLinearDistribution(min: 1.1, max: 1.5, minY: 10, maxY: 1)
        let buff = GoldPercentBuff(sourceName: Strings("enhanceOffer.source").local, duration: nil, goldFraction: goldFraction)
        let price = Random.selectFromNormalDistribution(
            mid: buff.getValue(whenTargeting: .player),
            boundFraction: 0.3
        )
        return AccessoryBuffEnhanceOffer(price: price, buff: buff)
    }

    // 15
    static func pricePercentBuffForAccessory(stage: Int) -> EnhanceOffer {
        let priceFraction = Random.selectFromLinearDistribution(min: 0.6, max: 0.9, minY: 1, maxY: 10)
        let buff = PricePercentBuff(sourceName: Strings("enhanceOffer.source").local, duration: nil, priceFraction: priceFraction)
        let price = Random.selectFromNormalDistribution(
            mid: buff.getValue(whenTargeting: .player),
            boundFraction: 0.3
        )
        return AccessoryBuffEnhanceOffer(price: price, buff: buff)
    }
    
}
