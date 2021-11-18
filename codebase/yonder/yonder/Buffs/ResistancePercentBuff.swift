//
//  ResistancePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ResistancePercentBuff: BuffAbstract {
    
    private let resistanceFraction: Double
    
    init(duration: Int, resistanceFraction: Double) {
        self.resistanceFraction = resistanceFraction
        
        super.init(duration: duration, type: .resistance, priority: 1)
    }
    
    override func applyResistance(damage: Int) -> Int? {
        return Int(round(Double(damage)*self.resistanceFraction))
    }
    
}
