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
    private(set) var potions = [PotionAbstract]()
    private(set) var armorPoints: Int = 0
    private(set) var headArmor: ArmorAbstract = Armors.newNoHeadArmor()
    private(set) var bodyArmor: ArmorAbstract = Armors.newNoBodyArmor()
    private(set) var legsArmor: ArmorAbstract = Armors.newNoLegsArmor()
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.isDead = maxHealth > 0 ? false : true
    }
    
    // MARK: - Health Related
    
    func restoreHealth(for amount: Int) {
        if self.health + amount > self.maxHealth {
            self.health = self.maxHealth
        }
        else {
            self.health += amount
        }
    }
    
    func restoreArmorPoints(for amount: Int) {
        if self.armorPoints + amount > self.getMaxArmorPoints() {
            self.armorPoints = self.getMaxArmorPoints()
        }
        else {
            self.armorPoints += amount
        }
    }
    
    func restore(for amount: Int) {
        let amountRemaining = max(0, amount - (self.maxHealth - self.health))
        self.restoreHealth(for: amount)
        self.restoreArmorPoints(for: amountRemaining)
    }
    
    func damage(for amount: Int) {
        if self.armorPoints > amount {
            self.armorPoints -= amount
        }
        else if self.armorPoints > 0 {
            let healthDamage = amount - self.armorPoints
            self.armorPoints = 0
            self.health -= healthDamage
        }
        else {
            self.health -= amount
        }
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
    
    func removeWeapon(_ weapon: WeaponAbstract) {
        guard let index = (self.weapons.firstIndex { $0.id == weapon.id }) else {
            return
        }
        self.weapons.remove(at: index)
    }
    
    // MARK: - Potions
    
    func addPotion(_ potion: PotionAbstract) {
        self.potions.append(potion)
    }
    
    // MARK: - Buffs
    
    func addBuff(_ buff: BuffAbstract) {
        self.buffs.append(buff)
    }
    
    func getAllBuffsInPriority() -> [BuffAbstract] {
        let allBuffs: [BuffAbstract] = self.buffs + self.headArmor.armorBuffs + self.bodyArmor.armorBuffs + self.legsArmor.armorBuffs
        // Ascending order
        return allBuffs.sorted(by: { $0.priority < $1.priority })
    }
    
    // MARK: - Armor
    
    func getMaxArmorPoints() -> Int {
        return self.headArmor.armorPoints + self.bodyArmor.armorPoints + self.legsArmor.armorPoints
    }
    
    func equipArmor(_ armor: ArmorAbstract) {
        switch armor.type {
        case .head:
            self.armorPoints = min(self.armorPoints, self.getMaxArmorPoints() - self.headArmor.armorPoints)
            self.headArmor = armor
            self.armorPoints += armor.armorPoints
            return
        case .body:
            self.armorPoints = min(self.armorPoints, self.getMaxArmorPoints() - self.bodyArmor.armorPoints)
            self.bodyArmor = armor
            self.armorPoints += armor.armorPoints
            return
        case .legs:
            self.armorPoints = min(self.armorPoints, self.getMaxArmorPoints() - self.legsArmor.armorPoints)
            self.bodyArmor = armor
            self.armorPoints += armor.armorPoints
            return
        }
    }
    
    // MARK: - Combat
    
    func useWeaponOn(target: ActorAbstract, weapon: WeaponAbstract) {
        weapon.use(owner: self, target: target)
        if weapon.remainingUses == 0 {
            self.removeWeapon(weapon)
        }
    }
    
}
