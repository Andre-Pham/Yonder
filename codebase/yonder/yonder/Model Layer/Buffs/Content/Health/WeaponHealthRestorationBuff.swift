//
//  WeaponHealthRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponHealthRestorationBuff: Buff {
    
    private let healthDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthDifference: Int) {
        self.healthDifference = healthDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: healthDifference,
            outgoingIncrease: Strings("buff.weaponHealthRestoration.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponHealthRestoration.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponHealthRestoration.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponHealthRestoration.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponHealthRestoration.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponHealthRestoration.effectsDescription.bidirectionalDecrease1Param"))
        
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
        if source is Weapon {
            return self.healthDifference + health
        }
        return health
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.healthDifference,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerHealthRestorationStat,
            foeStat: Pricing.foeHealthRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
