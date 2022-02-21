//
//  HealthRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class HealthRestorationPercentBuff: BuffAbstract {
    
    private let healthFraction: Double
    
    init(direction: BuffDirection, duration: Int?, healthFraction: Double) {
        self.healthFraction = healthFraction
        
        super.init(duration: duration, type: .health, direction: direction, priority: .second)
    }
    
    override func applyHealth(to health: Int, source: Any) -> Int? {
        return Int(round(Double(health)*self.healthFraction))
    }
    
}
