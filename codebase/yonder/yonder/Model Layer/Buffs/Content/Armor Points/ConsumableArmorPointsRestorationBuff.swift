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
            outgoingIncrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.ConsumableArmorRestoration.EffectsDescription.BidirectionalDecrease1Param)
        
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
        return Pricing.getBuffValue(
            flipIncomingOutgoing: target == .foe,
            incomingStat: Pricing.playerArmorPointsRestorationStat,
            outgoingStat: Pricing.foeArmorPointsRestorationStat,
            amount: self.armorPointsDifference,
            duration: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
