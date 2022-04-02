//
//  PotionDamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PotionDamagePercentBuff: BuffAbstract {
    
    private let damageFraction: Double
    
    init(direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromMultiplying(damageFraction) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.damage) \(Term.negativeEffectDirection(of: direction)) from \(Term.potions) by \(Term.getPercentageFromDouble(damageFraction))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .damage, direction: direction, priority: .first)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        if source is PotionAbstract {
            return Int(round(Double(damage)*self.damageFraction))
        }
        return damage
    }
    
}
