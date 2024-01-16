//
//  Actor.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class ActorAbstract: Storable, OnNoWeaponDurabilitySubscriber, OnNoPotionsRemainingSubscriber, OnNoConsumablesRemainingSubscriber, OnArmorArmorPointsChangeSubscriber, OnAccessoryArmorPointsChangeSubscriber, OnAccessoryHealthChangeSubscriber {
    
    @DidSetPublished private(set) var maxHealth: Int
    @DidSetPublished private(set) var health: Int
    @DidSetPublished private(set) var armorPoints: Int = 0
    public var maxArmorPoints: Int {
        let fromArmorPieces = self.allArmorPieces.reduce(0) { $0 + $1.armorPoints }
        let fromAccessories = self.accessorySlots.allAccessories.reduce(0) { $0 + $1.armorPointsBonus }
        return fromArmorPieces + fromAccessories
    }
    public var isDead: Bool {
        // Note: the actor may be classified as dead without actually being permanently dead
        // This means they can still be revived, or are waiting for delayed restoration values
        // For permanent death, refer to GameContext's "stable game states"
        return self.health <= 0
    }
    @DidSetPublished private(set) var statusEffects = [StatusEffect]()
    @DidSetPublished private(set) var timedEvents = [TimedEvent]()
    @DidSetPublished private(set) var weapons = [Weapon]()
    @DidSetPublished private(set) var buffs = [Buff]()
    @DidSetPublished private(set) var potions = [Potion]()
    @DidSetPublished private(set) var consumables = [Consumable]()
    @DidSetPublished private(set) var headArmor: Armor = NoArmor(type: .head)
    @DidSetPublished private(set) var bodyArmor: Armor = NoArmor(type: .body)
    @DidSetPublished private(set) var legsArmor: Armor = NoArmor(type: .legs)
    private(set) var accessorySlots = AccessorySlots()
    public var allArmorPieces: [Armor] {
        return [self.headArmor, self.bodyArmor, self.legsArmor]
    }
    public var allUpgradableArmorPieces: [Armor] {
        return self.allArmorPieces.filter { !$0.hasAttribute(.upgradesDisallowed) }
    }
    public let id: UUID
    public var isFullHealth: Bool {
        return !(self.health < self.maxHealth)
    }
    public var isFullArmorPoints: Bool {
        return !(self.armorPoints < self.maxArmorPoints)
    }
    public let delayedDamageValues = DelayedDamageValues()
    public let delayedRestorationValues = DelayedRestorationValues()
    
    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.id = UUID()
        
        OnNoWeaponDurabilityPublisher.subscribe(self)
        OnNoPotionsRemainingPublisher.subscribe(self)
        OnNoConsumablesRemainingPublisher.subscribe(self)
        OnArmorArmorPointsChangePublisher.subscribe(self)
        OnAccessoryHealthChangePublisher.subscribe(self)
        OnAccessoryArmorPointsChangePublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case maxHealth
        case health
        case armorPoints
        case statusEffects
        case timedEvents
        case weapons
        case buffs
        case potions
        case consumables
        case headArmor
        case bodyArmor
        case legsArmor
        case accessorySlots
        case id
        // Delayed values (damage/restoration) are volatile - they should never be storages of data
        // They act as an intermediate within a calculation, that is, they don't persist outside a calculation
    }

    required init(dataObject: DataObject) {
        self.maxHealth = dataObject.get(Field.maxHealth.rawValue)
        self.health = dataObject.get(Field.health.rawValue)
        self.armorPoints = dataObject.get(Field.armorPoints.rawValue)
        self.statusEffects = dataObject.getObjectArray(Field.statusEffects.rawValue, type: StatusEffectAbstract.self) as! [any StatusEffect]
        self.timedEvents = dataObject.getObjectArray(Field.timedEvents.rawValue, type: TimedEventAbstract.self) as! [any TimedEvent]
        self.weapons = dataObject.getObjectArray(Field.weapons.rawValue, type: Weapon.self)
        self.buffs = dataObject.getObjectArray(Field.buffs.rawValue, type: BuffAbstract.self) as! [any Buff]
        self.potions = dataObject.getObjectArray(Field.potions.rawValue, type: PotionAbstract.self) as! [any Potion]
        self.consumables = dataObject.getObjectArray(Field.consumables.rawValue, type: ConsumableAbstract.self) as! [any Consumable]
        self.headArmor = dataObject.getObject(Field.headArmor.rawValue, type: Armor.self)
        self.bodyArmor = dataObject.getObject(Field.bodyArmor.rawValue, type: Armor.self)
        self.legsArmor = dataObject.getObject(Field.legsArmor.rawValue, type: Armor.self)
        self.accessorySlots = dataObject.getObject(Field.accessorySlots.rawValue, type: AccessorySlots.self)
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        
        OnNoWeaponDurabilityPublisher.subscribe(self)
        OnNoPotionsRemainingPublisher.subscribe(self)
        OnNoConsumablesRemainingPublisher.subscribe(self)
        OnArmorArmorPointsChangePublisher.subscribe(self)
        OnAccessoryHealthChangePublisher.subscribe(self)
        OnAccessoryArmorPointsChangePublisher.subscribe(self)
    }

    func toDataObject() -> DataObject {
        // These should never actually consume anything
        // We call them anyways, just in case, for the sakes of "what if"
        self.delayedDamageValues.consume(by: self)
        self.delayedRestorationValues.consume(by: self)
        
        return DataObject(self)
            .add(key: Field.maxHealth.rawValue, value: self.maxHealth)
            .add(key: Field.health.rawValue, value: self.health)
            .add(key: Field.armorPoints.rawValue, value: self.armorPoints)
            .add(key: Field.statusEffects.rawValue, value: self.statusEffects as [StatusEffectAbstract])
            .add(key: Field.timedEvents.rawValue, value: self.timedEvents as [TimedEventAbstract])
            .add(key: Field.weapons.rawValue, value: self.weapons)
            .add(key: Field.buffs.rawValue, value: self.buffs as [BuffAbstract])
            .add(key: Field.potions.rawValue, value: self.potions as [PotionAbstract])
            .add(key: Field.consumables.rawValue, value: self.consumables as [ConsumableAbstract])
            .add(key: Field.headArmor.rawValue, value: self.headArmor)
            .add(key: Field.bodyArmor.rawValue, value: self.bodyArmor)
            .add(key: Field.legsArmor.rawValue, value: self.legsArmor)
            .add(key: Field.accessorySlots.rawValue, value: self.accessorySlots)
            .add(key: Field.id.rawValue, value: self.id.uuidString)
    }
    
    // MARK: - Max Health Related
    
    func adjustMaxHealth(by amount: Int) {
        self.maxHealth += amount
        if self.health > self.maxHealth {
            self.health = self.maxHealth
        }
    }
    
    /// Negatively adjusts the actor's max health, but also behaves as "damage", triggering damage publishers.
    func damageMaxHealth(by amount: Int) {
        var damageTaken: Int? = nil
        if self.health > self.maxHealth - amount {
            damageTaken = self.health - (self.maxHealth - amount)
            assert(damageTaken != nil && damageTaken! > 0, "Logic error found")
            OnActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
        }
        self.maxHealth -= amount
        if self.health > self.maxHealth {
            self.health = self.maxHealth
            assert(damageTaken != nil && damageTaken! > 0, "Logic error found")
            AfterActorTakeDamagePublisher.publish(actor: self, damageTaken: damageTaken!)
        }
    }
    
    func setMaxHealth(to maxHealth: Int) {
        self.maxHealth = maxHealth
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
        let (healthRestoration, armorPointsRestoration) = BuffApps.getAppliedRestoration(owner: sourceOwner, using: source, target: self, restoration: amount)
        self.restoreHealth(for: healthRestoration)
        self.restoreArmorPoints(for: armorPointsRestoration)
    }
    
    func setHealth(to amount: Int) {
        self.health = min(amount, self.maxHealth)
    }
    
    func setArmorPoints(to amount: Int) {
        if amount > self.maxArmorPoints {
            self.armorPoints = self.maxArmorPoints
        } else {
            self.armorPoints = max(amount, 0)
        }
    }
    
    func damage(for amount: Int) {
        OnActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
        if self.armorPoints > amount {
            self.armorPoints -= amount
        } else if self.armorPoints > 0 {
            let healthDamage = amount - self.armorPoints
            self.armorPoints = 0
            self.health -= healthDamage
        } else {
            self.health -= amount
        }
        AfterActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
    }
    
    func damageAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damage(for: adjustedAmount)
    }
    
    func damageHealth(for amount: Int) {
        OnActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
        self.health -= amount
        AfterActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
    }
    
    func damageHealthAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damageHealth(for: adjustedAmount)
    }
    
    func damageArmorPoints(for amount: Int) {
        if self.armorPoints - amount < 0 {
            let damageDealt = self.armorPoints
            if damageDealt > 0 {
                OnActorTakeDamagePublisher.publish(actor: self, damageTaken: damageDealt)
            }
            self.armorPoints = 0
            if damageDealt > 0 {
                AfterActorTakeDamagePublisher.publish(actor: self, damageTaken: damageDealt)
            }
        } else {
            OnActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
            self.armorPoints -= amount
            AfterActorTakeDamagePublisher.publish(actor: self, damageTaken: amount)
        }
    }
    
    func damageArmorPointsAdjusted(sourceOwner: ActorAbstract, using source: Any, for amount: Int) {
        let adjustedAmount = BuffApps.getAppliedDamage(owner: sourceOwner, using: source, target: self, damage: amount)
        self.damageArmorPoints(for: adjustedAmount)
    }
    
    // MARK: - Status Effects
    
    func addStatusEffect(_ statusEffect: StatusEffect) {
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
    
    func addTimedEvent(_ timedEvent: TimedEvent) {
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
    
    func getIndicativeDamage(of item: Item, opposition: ActorAbstract) -> Int {
        return BuffApps.getAppliedDamage(owner: self, using: item, target: opposition, damage: item.getIndicativeDamage(owner: self, opposition: opposition))
    }
    
    func getIndicativeRestoration(of item: Item) -> (Int, Int) {
        return BuffApps.getAppliedRestoration(owner: self, using: item, target: self, restoration: item.getIndicativeRestoration(owner: self, opposition: NoActor()))
    }
    
    func getIndicativeHealthRestoration(of item: Item) -> Int {
        return BuffApps.getAppliedHealthRestoration(owner: self, using: item, target: self, healthRestoration: item.getIndicativeHealthRestoration(owner: self, opposition: NoActor()))
    }
    
    func getIndicativeArmorPointsRestoration(of item: Item) -> Int {
        return BuffApps.getAppliedArmorPointsRestoration(owner: self, using: item, target: self, armorPointsRestoration: item.getIndicativeArmorPointsRestoration(owner: self, opposition: NoActor()))
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
    
    func onNoWeaponDurability(weapon: Weapon) {
        if self.weapons.contains(where: { $0.id == weapon.id }) {
            self.removeWeapon(weapon)
        }
    }
    
    /// Use a given weapon whilst an opposition exists.
    /// The opposition merely needs to be present. The weapon can be targeting either the owner (e.g. healing weapons) or the opposition (e.g. damage weapons).
    /// This actor technically doesn't need to own the weapon. For example, the DefaultPlayerWeapon isn't owned by the player, yet can be used.
    /// - Parameters:
    ///   - opposition: The opposition the actor is in combat with
    ///   - weapon: The weapon being used - not necessarily targeting the opposition
    func useWeaponWhere(opposition: ActorAbstract, weapon: Weapon) {
        OnActorAttackPublisher.publish(actor: self, weapon: weapon, target: opposition)
        OnActorUseItemPublisher.publish(actor: self, item: weapon, opposition: opposition)
        
        weapon.use(owner: self, opposition: opposition)
        
        AfterActorUseItemPublisher.publish(actor: self, item: weapon, opposition: opposition)
        AfterActorAttackPublisher.publish(actor: self, weapon: weapon, target: opposition)
    }
    
    // MARK: - Potions
    
    func addPotion(_ potion: Potion) {
        for ownedPotion in self.potions {
            if potion.isStackable(with: ownedPotion) {
                ownedPotion.adjustRemainingUses(by: potion.remainingUses)
                return
            }
        }
        self.potions.append(potion.clone())
    }
    
    func removePotion(_ potion: Potion) {
        guard let index = (self.potions.firstIndex { $0.id == potion.id }) else {
            return
        }
        self.potions.remove(at: index)
    }
    
    func onNoPotionsRemaining(potion: Potion) {
        if self.potions.contains(where: { $0.id == potion.id }) {
            self.removePotion(potion)
        }
    }
    
    func usePotionWhere(opposition: ActorAbstract?, potion: Potion) {
        OnActorUseItemPublisher.publish(actor: self, item: potion, opposition: opposition)
        
        potion.use(owner: self, opposition: opposition)
        
        AfterActorUseItemPublisher.publish(actor: self, item: potion, opposition: opposition)
    }
    
    // MARK: - Consumables
    
    func addConsumable(_ consumable: Consumable) {
        for ownedConsumable in self.consumables {
            if consumable.isStackable(with: ownedConsumable) {
                ownedConsumable.adjustRemainingUses(by: consumable.remainingUses)
                return
            }
        }
        self.consumables.append(consumable.clone())
    }
    
    func removeConsumable(_ consumable: Consumable) {
        guard let index = (self.consumables.firstIndex(where: { $0.id == consumable.id })) else {
            return
        }
        self.consumables.remove(at: index)
    }
    
    func onNoConsumablesRemaining(consumable: Consumable) {
        if self.consumables.contains(where: { $0.id == consumable.id }) {
            self.removeConsumable(consumable)
        }
    }
    
    func useConsumableWhere(opposition: ActorAbstract?, consumable: Consumable) {
        OnActorUseItemPublisher.publish(actor: self, item: consumable, opposition: opposition)
        
        consumable.use(owner: self, opposition: opposition)
        
        AfterActorUseItemPublisher.publish(actor: self, item: consumable, opposition: opposition)
    }
    
    func hasConsumable(_ consumable: Consumable) -> Bool {
        return self.consumables.contains(where: { $0.id == consumable.id })
    }
    
    // MARK: - Buffs
    
    func addBuff(_ buff: Buff) {
        self.buffs.append(buff.clone())
    }
    
    func addBuffByReference(_ buff: Buff) {
        self.buffs.append(buff)
    }
    
    func removeBuff(_ buff: Buff) {
        if let index = self.buffs.firstIndex(where: { $0.id == buff.id }) {
            self.buffs.remove(at: index)
        } else {
            assertionFailure("Attempted to remove non-existent buff")
        }
    }
    
    func getAllBuffsInPriority() -> [Buff] {
        var allBuffs: [Buff] = Array(self.buffs)
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
        var remainingBuffs = [Buff]()
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
    
    func equipArmor(_ armor: Armor) {
        let armor = armor.clone()
        switch armor.type {
        case .head:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.headArmor.armorPoints)
            self.headArmor = armor
            self.armorPoints += armor.armorPoints
        case .body:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.bodyArmor.armorPoints)
            self.bodyArmor = armor
            self.armorPoints += armor.armorPoints
        case .legs:
            self.armorPoints = min(self.armorPoints, self.maxArmorPoints - self.legsArmor.armorPoints)
            self.legsArmor = armor
            self.armorPoints += armor.armorPoints
        }
    }
    
    func hasArmorPieceEquipped(_ armor: Armor) -> Bool {
        return self.allArmorPieces.contains(where: { $0.id == armor.id })
    }
    
    func enhanceArmorPoints(of armor: Armor, armorPoints: Int) {
        assert(self.hasArmorPieceEquipped(armor), "Player is trying to enhance a piece of equipped armor that they actually don't have equipped")
        armor.adjustArmorPoints(by: armorPoints)
        self.restoreArmorPoints(for: armorPoints)
    }
    
    func unequipArmor(_ armor: Armor) {
        assert(self.hasArmorPieceEquipped(armor), "Player is trying to uneqiup armor they aren't wearing")
        self.armorPoints = min(self.armorPoints, self.maxArmorPoints - armor.armorPoints)
        switch armor.type {
        case .head:
            self.headArmor = NoArmor(type: .head)
        case .body:
            self.bodyArmor = NoArmor(type: .body)
        case .legs:
            self.legsArmor = NoArmor(type: .legs)
        }
    }
    
    func onArmorArmorPointsChange(armor: Armor, change: Int) {
        if self.hasArmorPieceEquipped(armor) {
            self.armorPoints += change
        }
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
    
    func unequipAccessory(id: UUID, cacheLocation: Bool = false) {
        if let accessory = self.accessorySlots.accessories.first(where: { $0.id == id }) {
            self.unequipAccessory(accessory, cacheLocation: cacheLocation)
        }
    }
    
    func unequipAccessory(_ accessory: Accessory, cacheLocation: Bool = false) {
        guard self.accessorySlots.hasEquipped(accessory) else {
            return
        }
        let previousMaxArmorPoints = self.maxArmorPoints
        self.accessorySlots.remove(accessory, cacheLocation: cacheLocation)
        self.adjustBonusHealth(by: -accessory.healthBonus)
        self.armorPoints = min(self.armorPoints, previousMaxArmorPoints - accessory.armorPointsBonus)
    }
    
    func onAccessoryHealthChange(accessory: Accessory, change: Int) {
        if self.accessorySlots.hasEquipped(accessory) {
            self.adjustBonusHealth(by: change)
        }
    }
    
    func onAccessoryArmorPointsChange(accessory: Accessory, change: Int) {
        if self.accessorySlots.hasEquipped(accessory) {
            self.armorPoints += change
        }
    }
    
    // MARK: - Equipment (Accessories/Armor)
    
    func hasEquipmentEffect(_ equipmentPill: EquipmentPill) -> Bool {
        for armorPiece in self.allArmorPieces {
            if armorPiece.hasEffect(equipmentPill) {
                return true
            }
        }
        return self.accessorySlots.hasEffect(equipmentPill)
    }
    
    func unequipEquipmentEffect(_ equipmentPill: EquipmentPill) {
        if let accessory = self.accessorySlots.allAccessories.first(where: { $0.hasEffect(equipmentPill) }) {
            self.unequipAccessory(accessory)
        } else if let armor = self.allArmorPieces.first(where: { $0.hasEffect(equipmentPill) }) {
            self.unequipArmor(armor)
        } else {
            assertionFailure("Player failed to unequip phoenix equipment")
        }
    }
    
}
