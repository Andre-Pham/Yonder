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
    public var maxArmorPoints: Int {
        let fromArmorPieces = self.allArmorPieces.reduce(0) { $0 + $1.armorPoints }
        let fromAccessories = self.accessorySlots.allAccessories.reduce(0) { $0 + $1.armorPointsBonus }
        return fromArmorPieces + fromAccessories
    }
    public var isDead: Bool {
        return self.health <= 0
    }
    @DidSetPublished private(set) var statusEffects = [StatusEffectAbstract]()
    @DidSetPublished private(set) var timedEvents = [TimedEventAbstract]()
    @DidSetPublished private(set) var weapons = [Weapon]()
    @DidSetPublished private(set) var buffs = [BuffAbstract]()
    @DidSetPublished private(set) var potions = [PotionAbstract]()
    @DidSetPublished private(set) var headArmor: ArmorAbstract = NoArmor(type: .head)
    @DidSetPublished private(set) var bodyArmor: ArmorAbstract = NoArmor(type: .body)
    @DidSetPublished private(set) var legsArmor: ArmorAbstract = NoArmor(type: .legs)
    public let accessorySlots = AccessorySlots()
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
        return !(self.armorPoints < self.maxArmorPoints)
    }
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
    }
    
    func onTurnCompletion() {
        self.triggerStatusEffects()
        self.decrementTimedEvents()
        self.decrementBuffs()
    }
    
    // MARK: - Max Health Related
    
    func adjustMaxHealth(by amount: Int) {
        self.maxHealth += amount
        if self.health > self.maxHealth {
            self.health = self.maxHealth
        }
    }
    
    func adjustBonusHealth(by amount: Int) {
        if amount > 0 {
            self.health += amount
        } else {
            self.health = min(self.health, self.maxHealth + amount)
        }
        self.maxHealth += amount
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
        if self.armorPoints + amount > self.maxArmorPoints {
            self.armorPoints = self.maxArmorPoints
        }
        else {
            self.armorPoints += amount
        }
    }
    
    func restoreArmorPointsAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedArmorPointsRestoration(owner: sourceOwner, using: source, target: self, armorPointsRestoration: amount)
        self.restoreArmorPoints(for: adjustedAmount)
    }
    
    func restore(for amount: Int) {
        let amountRemaining = max(0, amount - (self.maxHealth - self.health))
        self.restoreHealth(for: amount)
        self.restoreArmorPoints(for: amountRemaining)
    }
    
    func restoreAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let healthToAdjusted: Double = Double(BuffApps.getAppliedHealthRestoration(owner: sourceOwner, using: source, target: self, healthRestoration: amount))/Double(amount)
        let armorToAdjusted: Double = Double(BuffApps.getAppliedArmorPointsRestoration(owner: sourceOwner, using: source, target: self, armorPointsRestoration: amount))/Double(amount)
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
    
    func addStatusEffect(_ statusEffect: StatusEffectAbstract) {
        self.statusEffects.append(statusEffect.clone())
    }
    
    func triggerStatusEffects() {
        for statusEffect in self.statusEffects {
            statusEffect.applyEffect(actor: self)
            statusEffect.decrementTimeRemaining()
        }
        self.statusEffects.removeAll(where: { $0.timeRemaining <= 0 })
    }
    
    func clearStatusEffects() {
        self.statusEffects.removeAll()
    }
    
    // MARK: - Timed Events
    
    func addTimedEvent(_ timedEvent: TimedEventAbstract) {
        self.timedEvents.append(timedEvent.clone())
    }
    
    func decrementTimedEvents() {
        for timedEvent in self.timedEvents {
            timedEvent.decrementTimeRemaining(target: self)
        }
        self.timedEvents.removeAll(where: { $0.isFinished })
    }
    
    func clearTimedEvents() {
        self.timedEvents.removeAll()
    }
    
    // MARK: - Indicative Values
    
    func getIndicativeDamage(of item: ItemAbstract, opposition: ActorAbstract) -> Int {
        return BuffApps.getAppliedDamage(owner: self, using: item, target: opposition, damage: item.damage)
    }
    
    func getIndicativeHealthRestoration(of item: ItemAbstract) -> Int {
        return BuffApps.getAppliedHealthRestoration(owner: self, using: item, target: self, healthRestoration: item.healthRestoration)
    }
    
    func getIndicativeArmorPointsRestoration(of item: ItemAbstract) -> Int {
        return BuffApps.getAppliedArmorPointsRestoration(owner: self, using: item, target: self, armorPointsRestoration: item.armorPointsRestoration)
    }
    
    // MARK: - Weapons
    
    func addWeapon(_ weapon: Weapon) {
        self.weapons.append(weapon.clone())
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
        self.potions.append(potion.clone())
    }
    
    func removePotion(_ potion: PotionAbstract) {
        guard let index = (self.potions.firstIndex { $0.id == potion.id }) else {
            return
        }
        self.potions.remove(at: index)
    }
    
    // MARK: - Buffs
    
    func addBuff(_ buff: BuffAbstract) {
        self.buffs.append(buff.clone())
    }
    
    func getAllBuffsInPriority() -> [BuffAbstract] {
        var allBuffs: [BuffAbstract] = Array(self.buffs)
        for armorPiece in self.allArmorPieces {
            allBuffs.append(contentsOf: armorPiece.armorBuffs)
        }
        for accessory in self.accessorySlots.allAccessories {
            allBuffs.append(contentsOf: accessory.buffs)
        }
        // Ascending order
        return allBuffs.sorted(by: { $0.priority.rawValue < $1.priority.rawValue })
    }
    
    func decrementBuffs() {
        var remainingBuffs = [BuffAbstract]()
        for buff in self.buffs {
            buff.decrementTimeRemaining()
            if buff.isInfinite || buff.timeRemaining! > 0 {
                remainingBuffs.append(buff)
            }
        }
        self.buffs = remainingBuffs
    }
    
    func clearBuffs() {
        self.buffs.removeAll()
    }
    
    // MARK: - Armor
    
    func equipArmor(_ armor: ArmorAbstract) {
        let armor = armor.clone()
        switch armor.type {
        case .head:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.headArmor.armorPoints)
            self.headArmor = armor
            self.armorPoints += armor.armorPoints
            return
        case .body:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.bodyArmor.armorPoints)
            self.bodyArmor = armor
            self.armorPoints += armor.armorPoints
            return
        case .legs:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.legsArmor.armorPoints)
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
    
    // MARK: - Accessories
    
    func equipAccessory(_ accessory: Accessory, replacing: UUID?) {
        let accessory = accessory.clone()
        let previousMaxArmorPoints = self.maxArmorPoints
        if let replaced = self.accessorySlots.insert(accessory, replacing: replacing) {
            self.adjustBonusHealth(by: -replaced.healthBonus)
            self.armorPoints = min(self.armorPoints, previousMaxArmorPoints - replaced.armorPointsBonus)
        }
        if self.accessorySlots.hasEquipped(accessory) {
            self.adjustBonusHealth(by: accessory.healthBonus)
            self.armorPoints += accessory.armorPointsBonus
        }
    }
    
    func unequipAccessory(id: UUID) {
        if let accessory = self.accessorySlots.accessories.first(where: { $0.id == id }) {
            self.unequipAccessory(accessory)
        }
    }
    
    func unequipAccessory(_ accessory: Accessory) {
        guard self.accessorySlots.hasEquipped(accessory) else {
            return
        }
        let previousMaxArmorPoints = self.maxArmorPoints
        self.accessorySlots.remove(accessory)
        self.adjustBonusHealth(by: -accessory.healthBonus)
        self.armorPoints = min(self.armorPoints, previousMaxArmorPoints - accessory.armorPointsBonus)
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
