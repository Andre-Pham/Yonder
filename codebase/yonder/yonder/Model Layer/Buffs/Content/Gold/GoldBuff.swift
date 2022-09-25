//
//  GoldBuff.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class GoldBuff: BuffAbstract {
    
    private let goldDifference: Int
    
    init(sourceName: String, duration: Int?, goldDifference: Int) {
        self.goldDifference = goldDifference
        
        var effectsDescription: String? = nil
        if self.goldDifference < 0 {
            effectsDescription = Strings.Buff.Gold.EffectsDescription.IncomingDecrease2Param.localWithArgs(
                Strings.CurrencySymbol.local,
                String(self.goldDifference)
            )
        } else if self.goldDifference > 0 {
            effectsDescription = Strings.Buff.Gold.EffectsDescription.IncomingIncrease2Param.localWithArgs(
                Strings.CurrencySymbol.local,
                String(self.goldDifference)
            )
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .goldBonus,
            direction: .outgoing,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.goldDifference = original.goldDifference
        super.init(original)
    }
    
    override func applyGoldBonus(to gold: Int) -> Int {
        return self.goldDifference + gold
    }
    
}
