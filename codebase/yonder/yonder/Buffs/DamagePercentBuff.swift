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
        
        super.init(duration: duration, type: .damage, direction: direction, priority: 1)
    }
    
    override func applyDamage(to damage: Int, source: Any) -> Int? {
        return Int(round(Double(damage)*self.damageFraction))
    }
    
}
