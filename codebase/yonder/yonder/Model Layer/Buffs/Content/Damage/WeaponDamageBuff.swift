//
//  WeaponDamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponDamageBuff: Buff {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings.Buff.WeaponDamage.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.WeaponDamage.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.WeaponDamage.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.WeaponDamage.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.WeaponDamage.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.WeaponDamage.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .damage,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.damageDifference = original.damageDifference
        super.init(original)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int {
        if source is Weapon {
            return self.damageDifference + damage
        }
        return damage
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.damageDifference,
            defaultTargetsOwner: false,
            target: target,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
