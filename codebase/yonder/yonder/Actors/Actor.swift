//
//  Actor.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class ActorAbstract {
    
    private(set) var maxHealth: Int
    private(set) var health: Int
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
    }
    
    func heal(for amount: Int) {
        if self.health + amount > self.maxHealth {
            self.health = self.maxHealth
        }
        else {
            self.health += amount
        }
    }
    
    func damage(for amount: Int) {
        self.health -= amount
    }
    
    func setHealth(to amount: Int) {
        self.health = min(amount, maxHealth)
    }
    
}
