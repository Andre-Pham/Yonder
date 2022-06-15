//
//  ArmorRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ArmorPointsRestorationPercentBuff: BuffAbstract {
    
    private let armorPointsFraction: Double
    
    init(direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromMultiplying(armorPointsFraction) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.armorPoints) \(Term.positiveEffectDirection(of: direction)) by \(Term.getPercentageFromDouble(armorPointsFraction))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .armorPoints, direction: direction, priority: .second)
    }
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int? {
        return Int(round(Double(armorPoints)*self.armorPointsFraction))
    }
    
}
