//
//  DamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamagePercentBuff: BuffAbstract {
    
    private let damageFraction: Double
    
    init(direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromMultiplying(damageFraction) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.damage) \(Term.negativeEffectDirection(of: direction)) by \(Term.getPercentageFromDouble(damageFraction))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .damage, direction: direction, priority: .second)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        return Int(round(Double(damage)*self.damageFraction))
    }
    
}
