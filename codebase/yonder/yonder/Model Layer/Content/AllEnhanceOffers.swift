//
//  AllEnhanceOffers.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

enum EnhanceOffers {
    
    static func newWeaponDamage(stage: Int) -> EnhanceOffer {
        let damage = Random.selectFromNormalDistribution(min: 10.0, max: 30.0).compound(multiply: 1.3, index: stage).toRoundedInt().nearest(5)
        let priceTarget = Pricing.usingStage(stage: stage) {
            Pricing.playerDamageStat.getValue(amount: damage, uses: 5)
        }
        let price = Random.selectFromNormalDistribution(mid: priceTarget, boundFraction: 0.3)
        return WeaponDamageEnhanceOffer(
            price: damage,
            damage: price
        )
    }
    
    static func newWeaponLifesteal(stage: Int) -> EnhanceOffer {
        let fraction = Random.selectFromLinearDistribution(min: 0.5, max: 1.0, minY: 50, maxY: 10).nearest(0.1)
        let effectPill = LifestealEffectPill(lifestealFraction: fraction)
        let priceTarget = Pricing.usingStage(stage: stage) { effectPill.calculateBasePurchasePrice() }
        let price = Random.selectFromNormalDistribution(mid: priceTarget, boundFraction: 0.3)
        return WeaponEffectEnhanceOffer(
            price: price,
            effectPill: effectPill
        )
    }
    
    // Keep adding
    
}
