//
//  GoldPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class GoldPercentBuff: Buff {
    
    private let goldFraction: Double
    
    init(sourceName: String, duration: Int?, goldFraction: Double) {
        self.goldFraction = goldFraction
        
        var effectsDescription: String? = nil
        if self.goldFraction.multiplyingDecreases() {
            effectsDescription = Strings("buff.goldPercent.effectsDescription.incomingDecrease1Param").localWithArgs(goldFraction.toRelativePercentage())
        } else if self.goldFraction.multiplyingIncreases() {
            effectsDescription = Strings("buff.goldPercent.effectsDescription.incomingIncrease1Param").localWithArgs(goldFraction.toRelativePercentage())
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .goldBonus,
            direction: .incoming,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.goldFraction = original.goldFraction
        super.init(original)
    }
    
    override func applyGoldBonus(to gold: Int) -> Int {
        return Int(round(Double(gold)*self.goldFraction))
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            fraction: self.goldFraction,
            stat: Pricing.receivedGoldStat,
            timeRemaining: self.timeRemaining
        )
    }
    
}
