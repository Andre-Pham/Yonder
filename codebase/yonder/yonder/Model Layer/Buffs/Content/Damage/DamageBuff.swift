//
//  DamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamageBuff: BuffAbstract {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = Self.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings.Buff.Damage.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.Damage.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.Damage.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.Damage.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.Damage.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.Damage.EffectsDescription.BidirectionalDecrease1Param)
        
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
        return self.damageDifference + damage
    }
    
}
