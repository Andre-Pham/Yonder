//
//  HealthRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 20/9/2022.
//

import Foundation

class HealthRestorationBuff: Buff {
    
    private let healthDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthDifference: Int) {
        self.healthDifference = healthDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: healthDifference,
            outgoingIncrease: Strings.Buff.HealthRestoration.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.HealthRestoration.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.HealthRestoration.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.HealthRestoration.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.HealthRestoration.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.HealthRestoration.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .health,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.healthDifference = original.healthDifference
        super.init(original)
    }
    
    override func applyHealth(to health: Int, source: Any) -> Int {
        return self.healthDifference + health
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            flipIncomingOutgoing: target == .foe,
            incomingStat: Pricing.playerHealthRestorationStat,
            outgoingStat: Pricing.foeHealthRestorationStat,
            amount: self.healthDifference,
            duration: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
