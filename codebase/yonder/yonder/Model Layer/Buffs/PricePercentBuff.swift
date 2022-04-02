//
//  PricePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class PricePercentBuff: BuffAbstract {
    
    private let priceFraction: Double
    
    init(direction: BuffDirection, duration: Int?, priceFraction: Double) {
        self.priceFraction = priceFraction
        
        var effectsDescription: String? = nil
        if let magnitudeChange = Term.magnitudeChangeFromMultiplying(priceFraction) {
            effectsDescription = "\(magnitudeChange.capitalized) \(Term.gold) \(Term.goldPaymentDirection(of: direction)) by \(Term.getPercentageFromDouble(priceFraction))"
        }
        
        super.init(effectsDescription: effectsDescription, duration: duration, type: .health, direction: direction, priority: .second)
    }
    
    override func applyPrice(to gold: Int) -> Int? {
        return Int(round(Double(gold)*self.priceFraction))
    }
    
}
