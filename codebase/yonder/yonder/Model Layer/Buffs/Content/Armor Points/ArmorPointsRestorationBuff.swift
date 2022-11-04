//
//  ArmorPointsRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 20/9/2022.
//

import Foundation

class ArmorPointsRestorationBuff: Buff {
    
    private let armorPointsDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsDifference: Int) {
        self.armorPointsDifference = armorPointsDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: armorPointsDifference,
            outgoingIncrease: Strings.Buff.ArmorRestoration.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.ArmorRestoration.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.ArmorRestoration.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.ArmorRestoration.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.ArmorRestoration.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.ArmorRestoration.EffectsDescription.BidirectionalDecrease1Param)
        
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
        return self.armorPointsDifference + armorPoints
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
