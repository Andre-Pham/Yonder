//
//  PotionDamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class PotionDamageBuff: Buff {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings("buff.potionDamage.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.potionDamage.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.potionDamage.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.potionDamage.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.potionDamage.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.potionDamage.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .damage,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.damageDifference = original.damageDifference
        super.init(original)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int {
        if source is Potion {
            return self.damageDifference + damage
        }
        return damage
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.damageDifference,
            defaultTargetsOwner: false,
            target: target,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
