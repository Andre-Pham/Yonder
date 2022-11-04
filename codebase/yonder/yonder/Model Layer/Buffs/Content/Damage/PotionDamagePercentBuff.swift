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
            outgoingIncrease: Strings.Buff.PotionDamagePercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.PotionDamagePercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.PotionDamagePercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.PotionDamagePercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.PotionDamagePercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.PotionDamagePercent.EffectsDescription.BidirectionalDecrease1Param)
        
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
