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
    // Smaller numbers are higher priority; calculations apply addition then multiplication
    // Addition has a priority of 0, multiplication has a priority of 1
    var priority: Int
    
    init(duration: Int, type: BuffType, priority: Int) {
        self.timeRemaining = duration
        self.type = type
        self.priority = priority
    }
    
    func decrementTimeRemaining() {
        self.timeRemaining -= 1
    }
    
    func applyDamage(to damage: Int) -> Int? {
        return nil
    }
    
    func applyResistance(to damage: Int) -> Int? {
        return nil
    }
    
}
