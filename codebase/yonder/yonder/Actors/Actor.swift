//
//  Actor.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class ActorAbstract {
    
    private(set) var maxHealth: Int
    private(set) var health: Int {
        didSet {
            if health <= 0 {
                self.isDead = true
            }
        }
    }
    private(set) var isDead: Bool
    private(set) var statusEffects = [StatusEffect]()
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.isDead = maxHealth > 0 ? false : true
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
    
    func addStatusEffect(_ statusEffect: StatusEffect) {
        self.statusEffects.append(statusEffect)
    }
    
    func triggerStatusEffects() {
        for statusEffect in self.statusEffects {
            statusEffect.applyEffect(actor: self)
        }
    }
    
}
