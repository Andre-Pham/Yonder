//
//  ArmorRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ArmorPointsRestorationPercentBuff: BuffAbstract {
    
    private let armorPointsFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        let effectsDescription = Self.buildPercentageEffectsDescription(
            direction: direction,
            fraction: armorPointsFraction,
            outgoingIncrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.ArmorRestorationPercent.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .armorPoints,
            direction: direction,
            priority: .second)
    }
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int? {
        return Int(round(Double(armorPoints)*self.armorPointsFraction))
    }
    
}
