//
//  ArmorRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ArmorPointsRestorationPercentBuff: BuffAbstract {
    
    private let armorPointsFraction: Double
    
    init(direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        super.init(duration: duration, type: .armorPoints, direction: direction, priority: 1)
    }
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int? {
        return Int(round(Double(armorPoints)*self.armorPointsFraction))
    }
    
}
