//
//  DamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamagePercentBuff: BuffAbstract {
    
    private let damageFraction: Double
    
    init(duration: Int, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        super.init(duration: duration, type: .damage, priority: 1)
    }
    
    override func applyDamage(damage: Int) -> Int? {
        return Int(round(Double(damage)*self.damageFraction))
    }
    
}
