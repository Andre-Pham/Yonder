//
//  File.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

enum BuffType {
    // For each type, add a skeleton function in BuffAbstract to be overridden in the buff class
    case damage
    case health
    case price
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
    
    func applyDamage(to damage: Int, source: Any) -> Int? {
        return nil
    }
    
    func applyHealth(to health: Int, source: Any) -> Int? {
        return nil
    }
    
    func applyPrice(to gold: Int) -> Int? {
        return nil
    }
    
}
