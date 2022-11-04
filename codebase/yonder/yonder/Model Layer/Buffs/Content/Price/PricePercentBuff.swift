//
//  PricePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class PricePercentBuff: Buff {
    
    private let priceFraction: Double
    
    init(sourceName: String, duration: Int?, priceFraction: Double) {
        self.priceFraction = priceFraction
        
        var effectsDescription: String? = nil
        if self.priceFraction.multiplyingDecreases() {
            effectsDescription = Strings.Buff.PricePercent.EffectsDescription.OutgoingDecrease1Param.localWithArgs(priceFraction.toRelativePercentage())
        } else if self.priceFraction.multiplyingIncreases() {
            effectsDescription = Strings.Buff.PricePercent.EffectsDescription.OutgoingIncrease1Param.localWithArgs(priceFraction.toRelativePercentage())
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .price,
            direction: .outgoing,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.priceFraction = original.priceFraction
        super.init(original)
    }
    
    override func applyPrice(to gold: Int) -> Int {
        return Int(round(Double(gold)*self.priceFraction))
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            fraction: self.priceFraction,
            stat: Pricing.priceStat,
            timeRemaining: self.timeRemaining
        )
    }
    
}
