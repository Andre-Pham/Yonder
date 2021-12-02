//
//  HealthRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealthRestorationPercentBuff: BuffAbstract {
    
    private let healthFraction: Double
    
    init(duration: Int, healthFraction: Double) {
        self.healthFraction = healthFraction
        
        super.init(duration: duration, type: .health, priority: 1)
    }
    
    override func applyHealth(to health: Int, source: Any) -> Int? {
        return Int(round(Double(health)*self.healthFraction))
    }
    
}
