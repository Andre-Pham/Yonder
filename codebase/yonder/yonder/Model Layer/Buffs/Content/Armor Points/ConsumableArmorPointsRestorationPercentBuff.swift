//
//  ConsumableArmorPointsRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class ConsumableArmorPointsRestorationPercentBuff: Buff {
    
    private let armorPointsFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: armorPointsFraction,
            outgoingIncrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.ConsumableArmorRestorationPercent.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .armorPoints,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.armorPointsFraction = original.armorPointsFraction
        super.init(original)
    }
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int {
        if source is Consumable {
            return Int(round(Double(armorPoints)*self.armorPointsFraction))
        }
        return armorPoints
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            flipIncomingOutgoing: target == .foe,
            incomingStat: Pricing.playerArmorPointsRestorationStat,
            outgoingStat: Pricing.foeArmorPointsRestorationStat,
            fraction: self.armorPointsFraction,
            duration: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
