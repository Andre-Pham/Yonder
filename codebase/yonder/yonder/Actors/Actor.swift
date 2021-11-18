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
    private(set) var statusEffects = [StatusEffectAbstract]()
    private(set) var timedEvents = [TimedEventAbstract]()
    private(set) var weapons = [WeaponAbstract]()
    private(set) var buffs = [BuffAbstract]()
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.isDead = maxHealth > 0 ? false : true
    }
    
    // MARK: - Health Related
    
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
    
    // MARK: - Status Effects
    
    func addStatusEffect(_ statusEffect: StatusEffectAbstract) {
        self.statusEffects.append(statusEffect)
    }
    
    func triggerStatusEffects() {
        for statusEffect in self.statusEffects {
            statusEffect.applyEffect(actor: self)
        }
    }
    
    // MARK: - Timed Events
    
    func addTimedEvent(_ timedEvent: TimedEventAbstract) {
        self.timedEvents.append(timedEvent)
    }
    
    func decrementTimedEvents() {
        var remainingTimedEvents = [TimedEventAbstract]()
        for timedEvent in self.timedEvents {
            timedEvent.decrementTimeRemaining()
            if timedEvent.timeRemaining > 0 {
                remainingTimedEvents.append(timedEvent)
            }
        }
        self.timedEvents = remainingTimedEvents
    }
    
    // MARK: - Weapons
    
    func addWeapon(_ weapon: WeaponAbstract) {
        self.weapons.append(weapon)
    }
    
    // MARK: - Buffs
    
    func addBuff(_ buff: BuffAbstract) {
        self.buffs.append(buff)
    }
    
    func orderBuffsInPriority() {
        // Ascending order
        self.buffs = self.buffs.sorted(by: { $0.priority < $1.priority })
    }
    
    // MARK: - Combat
    
    func attack(target: ActorAbstract, weapon: WeaponAbstract) {
        weapon.use(owner: self, target: target)
    }
    
}
