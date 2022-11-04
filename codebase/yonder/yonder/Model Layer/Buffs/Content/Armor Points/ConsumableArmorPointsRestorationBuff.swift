//
//  ConsumableArmorPointsRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class ConsumableArmorPointsRestorationBuff: Buff {
    
    private let armorPointsDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsDifference: Int) {
        self.armorPointsDifference = armorPointsDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: armorPointsDifference,
            outgoingIncrease: Strings("buff.consumableArmorRestoration.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.consumableArmorRestoration.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.consumableArmorRestoration.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.consumableArmorRestoration.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.consumableArmorRestoration.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.consumableArmorRestoration.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .armorPoints,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.armorPointsDifference = original.armorPointsDifference
        super.init(original)
    }
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int {
        if source is Consumable {
            return self.armorPointsDifference + armorPoints
        }
        return armorPoints
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.armorPointsDifference,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerArmorPointsRestorationStat,
            foeStat: Pricing.foeArmorPointsRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
