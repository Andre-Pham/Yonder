//
//  WeaponDamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponDamagePercentBuff: BuffAbstract {
    
    private let damageFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        let effectsDescription = Self.buildPercentageEffectsDescription(
            direction: direction,
            fraction: damageFraction,
            outgoingIncrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.WeaponDamagePercent.EffectsDescription.BidirectionalDecrease1Param)
        
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
        if source is Weapon {
            return Int(round(Double(damage)*self.damageFraction))
        }
        return damage
    }
    
}
