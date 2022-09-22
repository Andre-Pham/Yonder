//
//  PotionDamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class PotionDamageBuff: BuffAbstract {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = Self.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings.Buff.PotionDamage.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.PotionDamage.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.PotionDamage.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.PotionDamage.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.PotionDamage.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.PotionDamage.EffectsDescription.BidirectionalDecrease1Param)
        
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
    
}
