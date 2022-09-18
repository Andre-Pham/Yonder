//
//  DamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamagePercentBuff: BuffAbstract {
    
    private let damageFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        let effectsDescription = Self.buildPercentageEffectsDescription(
            direction: direction,
            fraction: damageFraction,
            outgoingIncrease: Strings.Buff.DamagePercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.DamagePercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.DamagePercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.DamagePercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.DamagePercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.DamagePercent.EffectsDescription.BidirectionalDecrease1Param)
        
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
        return Int(round(Double(damage)*self.damageFraction))
    }
    
}
