//
//  ArmorRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ArmorPointsRestorationPercentBuff: Buff {
    
    private let armorPointsFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: armorPointsFraction,
            outgoingIncrease: Strings("buff.armorRestorationPercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.armorRestorationPercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.armorRestorationPercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.armorRestorationPercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.armorRestorationPercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.armorRestorationPercent.effectsDescription.bidirectionalDecrease1Param"))
        
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
        return Int(round(Double(armorPoints)*self.armorPointsFraction))
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
