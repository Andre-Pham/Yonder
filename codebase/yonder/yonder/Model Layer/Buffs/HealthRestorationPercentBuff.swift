//
//  HealthRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealthRestorationPercentBuff: BuffAbstract {
    
    private let healthFraction: Double
    
    init(direction: BuffDirection, duration: Int?, healthFraction: Double) {
        self.healthFraction = healthFraction
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromMultiplying(healthFraction) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.health) \(Term.positiveEffectDirection(of: direction)) by \(Term.getPercentageFromDouble(healthFraction))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .health, direction: direction, priority: .second)
    }
    
    override func applyHealth(to health: Int, source: Any) -> Int? {
        return Int(round(Double(health)*self.healthFraction))
    }
    
}
