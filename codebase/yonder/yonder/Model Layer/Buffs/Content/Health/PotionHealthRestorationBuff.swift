//
//  PotionHealthRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class PotionHealthRestorationBuff: BuffAbstract {
    
    private let healthDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthDifference: Int) {
        self.healthDifference = healthDifference
        
        let effectsDescription = Self.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: healthDifference,
            outgoingIncrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.PotionHealthRestoration.EffectsDescription.BidirectionalDecrease1Param)
        
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
        if source is Potion {
            return self.healthDifference + health
        }
        return health
    }
    
}
