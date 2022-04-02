//
//  DamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamageBuff: BuffAbstract {
    
    private let damageDifference: Int
    
    init(direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromAdding(damageDifference) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.damage) \(Term.negativeEffectDirection(of: direction)) by \(abs(damageDifference))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .damage, direction: direction, priority: .first)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        return self.damageDifference + damage
    }
    
}
