//
//  PotionDamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PotionDamagePercentBuff: Buff {
    
    private let damageFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: damageFraction,
            outgoingIncrease: Strings("buff.potionDamagePercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.potionDamagePercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.potionDamagePercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.potionDamagePercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.potionDamagePercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.potionDamagePercent.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .damage,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.damageFraction = original.damageFraction
        super.init(original)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int {
        if source is Potion {
            return Int(round(Double(damage)*self.damageFraction))
        }
        return damage
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            fraction: self.damageFraction,
            defaultTargetsOwner: false,
            target: target,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
