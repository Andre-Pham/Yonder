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
            outgoingIncrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.consumableArmorRestorationPercent.effectsDescription.bidirectionalDecrease1Param"))
        
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
        return Pricing.getTargetedBuffValue(
            fraction: self.armorPointsFraction,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerArmorPointsRestorationStat,
            foeStat: Pricing.foeArmorPointsRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
