//
//  Actor.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class ActorAbstract {
    
    @DidSetPublished private(set) var maxHealth: Int
    @DidSetPublished private(set) var health: Int
    @DidSetPublished private(set) var armorPoints: Int = 0
    public var isDead: Bool {
        return self.health <= 0
    }
    private(set) var statusEffects = [StatusEffect]()
    private(set) var timedEvents = [TimedEvent]()
    @DidSetPublished private(set) var weapons = [Weapon]()
    private(set) var buffs = [BuffAbstract]()
    @DidSetPublished private(set) var potions = [PotionAbstract]()
    @DidSetPublished private(set) var headArmor: ArmorAbstract = Armors.newNoHeadArmor()
    @DidSetPublished private(set) var bodyArmor: ArmorAbstract = Armors.newNoBodyArmor()
    @DidSetPublished private(set) var legsArmor: ArmorAbstract = Armors.newNoLegsArmor()
    public var allArmorPieces: [ArmorAbstract] {
        return [self.headArmor, self.bodyArmor, self.legsArmor]
    }
    public var allUpgradableArmorPieces: [ArmorAbstract] {
        return self.allArmorPieces.filter { !$0.hasAttribute(.upgradesDisallowed) }
    }
    public let id = UUID()
    public var isFullHealth: Bool {
        return !(self.health < self.maxHealth)
    }
    public var isFullArmorPoints: Bool {
        return !(self.armorPoints < self.getMaxArmorPoints())
    }
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
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
    
    func restoreHealthAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedHealthRestoration(owner: sourceOwner, using: source, target: self, healthRestoration: amount)
        self.restoreHealth(for: adjustedAmount)
    }
    
    func restoreArmorPoints(for amount: Int) {
        if self.armorPoints + amount > self.getMaxArmorPoints() {
            self.armorPoints = self.getMaxArmorPoints()
        }
        else {
            self.armorPoints += amount
        }
    }
    
    func restoreArmorPointsAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedArmorRestoration(owner: sourceOwner, using: source, target: self, armorPointsRestoration: amount)
        self.restoreArmorPoints(for: adjustedAmount)
    }
    
    func restore(for amount: Int) {
        let amountRemaining = max(0, amount - (self.maxHealth - self.health))
        self.restoreHealth(for: amount)
        self.restoreArmorPoints(for: amountRemaining)
    }
    
    func restoreAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let healthToAdjusted: Double = Double(BuffApps.getAppliedHealthRestoration(owner: sourceOwner, using: source, target: self, healthRestoration: amount))/Double(amount)
        let armorToAdjusted: Double = Double(BuffApps.getAppliedArmorRestoration(owner: sourceOwner, using: source, target: self, armorPointsRestoration: amount))/Double(amount)
        let amountRemaining = max(0, Int(round(Double(amount)*healthToAdjusted)) - (self.maxHealth - self.health))
        let amountRemainingReadjusted = Int(round(armorToAdjusted*Double(amountRemaining)/healthToAdjusted))
        self.restoreHealth(for: Int(round(Double(amount)*healthToAdjusted)))
        self.restoreArmorPoints(for: amountRemainingReadjusted)
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
    
    func damageAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damage(for: adjustedAmount)
    }
    
    func damageHealth(for amount: Int) {
        self.health -= amount
    }
    
    func damageHealthAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damageHealth(for: adjustedAmount)
    }
    
    func damageArmorPoints(for amount: Int) {
        if self.armorPoints - amount < 0 {
            self.armorPoints = 0
        }
        else {
            self.armorPoints -= amount
        }
    }
    
    func damageArmorPointsAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damageArmorPoints(for: adjustedAmount)
    }
    
    // MARK: - Status Effects
    
    func addStatusEffect(_ statusEffect: StatusEffect) {
        self.statusEffects.append(statusEffect)
    }
    
    func triggerStatusEffects() {
        for statusEffect in self.statusEffects {
            statusEffect.applyEffect(actor: self)
        }
    }
    
    // MARK: - Timed Events
    
    func addTimedEvent(_ timedEvent: TimedEvent) {
        self.timedEvents.append(timedEvent)
    }
    
    func decrementTimedEvents() {
        var remainingTimedEvents = [TimedEvent]()
        for timedEvent in self.timedEvents {
            timedEvent.decrementTimeRemaining()
            if timedEvent.timeRemaining > 0 {
                remainingTimedEvents.append(timedEvent)
            }
        }
        self.timedEvents = remainingTimedEvents
    }
    
    // MARK: - Weapons
    
    func addWeapon(_ weapon: Weapon) {
        self.weapons.append(weapon)
    }
    
    func removeWeapon(_ weapon: Weapon) {
        guard let index = (self.weapons.firstIndex { $0.id == weapon.id }) else {
            return
        }
        self.weapons.remove(at: index)
    }
    
    // MARK: - Potions
    
    func addPotion(_ potion: PotionAbstract) {
        for ownedPotion in self.potions {
            if potion.isStackable(with: ownedPotion) {
                ownedPotion.adjustRemainingUses(by: potion.remainingUses)
                return
            }
        }
        self.potions.append(potion)
    }
    
    func removePotion(_ potion: PotionAbstract) {
        guard let index = (self.potions.firstIndex { $0.id == potion.id }) else {
            return
        }
        self.potions.remove(at: index)
    }
    
    // MARK: - Buffs
    
    func addBuff(_ buff: BuffAbstract) {
        self.buffs.append(buff)
    }
    
    func getAllBuffsInPriority() -> [BuffAbstract] {
        let allBuffs: [BuffAbstract] = self.buffs + self.headArmor.armorBuffs + self.bodyArmor.armorBuffs + self.legsArmor.armorBuffs
        // Ascending order
        return allBuffs.sorted(by: { $0.priority.rawValue < $1.priority.rawValue })
    }
    
    // MARK: - Armor
    
    func getMaxArmorPoints() -> Int {
        return self.allArmorPieces.reduce(0) { $0 + $1.armorPoints }
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
    
    func hasArmorPieceEquipped(_ armor: ArmorAbstract) -> Bool {
        return self.allArmorPieces.contains(where: { $0.id == armor.id })
    }
    
    func enhanceArmorPoints(of armor: ArmorAbstract, armorPoints: Int) {
        guard self.hasArmorPieceEquipped(armor) else {
            YonderDebugging.printError(message: "Player is trying to enhance a piece of equipped armor that they actually don't have equipped", functionName: #function, className: "\(type(of: self))")
            return
        }
        armor.adjustArmorPoints(by: armorPoints)
        self.restoreArmorPoints(for: armorPoints)
    }
    
    // MARK: - Actor Interactions
    
    func useWeaponWhere(opposition: ActorAbstract, weapon: Weapon) {
        weapon.use(owner: self, opposition: opposition)
        if weapon.remainingUses == 0 {
            self.removeWeapon(weapon)
        }
        
        if let foe = opposition as? Foe, let player = self as? Player {
            foe.completeTurn(player: player)
        }
    }
    
    func usePotionWhere(opposition: ActorAbstract, potion: PotionAbstract) {
        potion.use(owner: self, opposition: opposition)
        if potion.remainingUses == 0 {
            self.removePotion(potion)
        }
    }
    
}
