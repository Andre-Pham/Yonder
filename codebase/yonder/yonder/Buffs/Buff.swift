//
//  File.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

enum BuffType {
    case damage
    case resistance
}

class BuffAbstract {
    
    var timeRemaining: Int
    var type: BuffType
    
    init(duration: Int, type: BuffType) {
        self.timeRemaining = duration
        self.type = type
    }
    
    func decrementTimeRemaining() {
        self.timeRemaining -= 1
    }
    
    func applyDamage(damage: Int) -> Int? {
        return nil
    }
    
    func applyResistance(damage: Int) -> Int? {
        return nil
    }
    
}
