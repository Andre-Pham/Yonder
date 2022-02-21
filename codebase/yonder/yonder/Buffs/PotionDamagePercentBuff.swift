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
        
        super.init(duration: duration, type: .damage, direction: direction, priority: 1)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        if source is PotionAbstract {
            return Int(round(Double(damage)*self.damageFraction))
        }
        return damage
    }
    
}
