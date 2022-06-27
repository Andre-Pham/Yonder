//
//  PricePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class PricePercentBuff: BuffAbstract {
    
    private let priceFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, priceFraction: Double) {
        self.priceFraction = priceFraction
        
        let effectsDescription = Self.buildPercentageEffectsDescription(
            direction: direction,
            fraction: priceFraction,
            outgoingIncrease: Strings.Buff.PricePercent.EffectsDescription.OutgoingIncrease1Param,
            outgoingDecrease: Strings.Buff.PricePercent.EffectsDescription.OutgoingDecrease1Param,
            incomingIncrease: Strings.Buff.PricePercent.EffectsDescription.IncomingIncrease1Param,
            incomingDecrease: Strings.Buff.PricePercent.EffectsDescription.IncomingDecrease1Param,
            bidirectionalIncrease: Strings.Buff.PricePercent.EffectsDescription.BidirectionalIncrease1Param,
            bidirectionalDecrease: Strings.Buff.PricePercent.EffectsDescription.BidirectionalDecrease1Param)
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .price,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.priceFraction = original.priceFraction
        super.init(original)
    }
    
    override func applyPrice(to gold: Int) -> Int? {
        return Int(round(Double(gold)*self.priceFraction))
    }
    
}
