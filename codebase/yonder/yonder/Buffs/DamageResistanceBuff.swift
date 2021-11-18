//
//  ResistanceBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamageResistanceBuff: BuffAbstract {
    
    private let resistance: Double
    
    init(duration: Int, resistance: Double) {
        self.resistance = resistance
        
        super.init(duration: duration, type: .resistance)
    }
    
    override func applyResistance(damage: Int) -> Int? {
        return Int(round(Double(damage)*resistance))
    }
    
}
