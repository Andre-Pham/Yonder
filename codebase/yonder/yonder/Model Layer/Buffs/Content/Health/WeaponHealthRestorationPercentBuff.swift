//
//  WeaponHealthRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponHealthRestorationPercentBuff: BuffAbstract {
    
    private let healthFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthFraction: Double) {
        self.healthFraction = healthFraction
        
        let effectsDescription = Self.buildPercentageEffectsDescription(
            direction: direction,
            fraction: healthFraction,
            outgoingIncrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.WeaponHealthRestorationPercent.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .health,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.healthFraction = original.healthFraction
        super.init(original)
    }
    
    override func applyHealth(to health: Int, source: Any) -> Int {
        if source is Weapon {
            return Int(round(Double(health)*self.healthFraction))
        }
        return health
    }
    
}
