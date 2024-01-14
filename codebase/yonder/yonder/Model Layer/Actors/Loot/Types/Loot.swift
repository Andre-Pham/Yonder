//
//  Loot.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation

class Loot: Storable {
    
    @DidSetPublished private(set) var armorLoot = [Armor]()
    @DidSetPublished private(set) var weaponLoot = [Weapon]()
    @DidSetPublished private(set) var potionLoot = [Potion]()
    @DidSetPublished private(set) var accessoryLoot = [Accessory]()
    @DidSetPublished private(set) var consumableLoot = [Consumable]()
    @DidSetPublished private(set) var goldLoot: Int = 0
    /// The total number of pieces of loot that are available
    public var optionCount: Int {
        var sum = 0
        sum += self.armorLoot.count
        sum += self.weaponLoot.count
        sum += self.potionLoot.count
        sum += self.accessoryLoot.count
        sum += self.consumableLoot.count
        if self.goldLoot > 0 {
            sum += 1
        }
        return sum
    }
    /// True if loot currently can be collected
    /// Override this in subclasses that wish to control this condition
    public var canCollect: Bool {
        return true
    }
    public let id: UUID
    
    init() {
        self.id = UUID()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case id
        case armorLoot
        case weaponLoot
        case potionLoot
        case accessoryLoot
        case consumableLoot
        case goldLoot
        case name
    }

    required init(dataObject: DataObject) {
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        self.armorLoot = dataObject.getObjectArray(Field.armorLoot.rawValue, type: Armor.self)
        self.weaponLoot = dataObject.getObjectArray(Field.weaponLoot.rawValue, type: Weapon.self)
        self.potionLoot = dataObject.getObjectArray(Field.potionLoot.rawValue, type: PotionAbstract.self) as! [any Potion]
        self.accessoryLoot = dataObject.getObjectArray(Field.accessoryLoot.rawValue, type: Accessory.self)
        self.consumableLoot = dataObject.getObjectArray(Field.consumableLoot.rawValue, type: ConsumableAbstract.self) as! [any Consumable]
        self.goldLoot = dataObject.get(Field.goldLoot.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.id.rawValue, value: self.id.uuidString)
            .add(key: Field.armorLoot.rawValue, value: self.armorLoot)
            .add(key: Field.weaponLoot.rawValue, value: self.weaponLoot)
            .add(key: Field.potionLoot.rawValue, value: self.potionLoot as [PotionAbstract])
            .add(key: Field.accessoryLoot.rawValue, value: self.accessoryLoot)
            .add(key: Field.consumableLoot.rawValue, value: self.consumableLoot as [ConsumableAbstract])
            .add(key: Field.goldLoot.rawValue, value: self.goldLoot)
    }

    // MARK: - Functions
    
    /// Called when any piece of loot is collected. 
    /// Override this in subclasses that wish to observe this behaviour.
    func afterLootCollection() { }
    
    func addArmorLoot(_ armor: Armor) {
        self.armorLoot.append(armor.clone())
    }
    
    func addWeaponLoot(_ weapon: Weapon) {
        self.weaponLoot.append(weapon.clone())
    }
    
    func addPotionLoot(_ potion: Potion) {
        self.potionLoot.append(potion.clone())
    }
    
    func addAccessoryLoot(_ accessory: Accessory) {
        self.accessoryLoot.append(accessory.clone())
    }
    
    func addConsumableLoot(_ consumable: Consumable) {
        self.consumableLoot.append(consumable.clone())
    }
    
    func addGoldLoot(_ gold: Int) {
        self.goldLoot += gold
    }
    
    func collectArmor(id: UUID, player: Player) {
        guard self.canCollect else {
            return
        }
        if let index = self.armorLoot.firstIndex(where: { $0.id == id }) {
            let armor = self.armorLoot.remove(at: index)
            player.equipArmor(armor)
        }
        self.afterLootCollection()
    }
    
    func collectWeapon(id: UUID, player: Player) {
        guard self.canCollect else {
            return
        }
        if let index = self.weaponLoot.firstIndex(where: { $0.id == id }) {
            let weapon = self.weaponLoot.remove(at: index)
            player.addWeapon(weapon)
        }
        self.afterLootCollection()
    }
    
    func collectPotion(id: UUID, player: Player) {
        guard self.canCollect else {
            return
        }
        if let index = self.potionLoot.firstIndex(where: { $0.id == id }) {
            let potions = self.potionLoot.remove(at: index)
            player.addPotion(potions)
        }
        self.afterLootCollection()
    }
    
    func collectAccessory(id: UUID, replacing: UUID?, player: Player) {
        guard self.canCollect else {
            return
        }
        if let index = self.accessoryLoot.firstIndex(where: { $0.id == id }) {
            let accessory = self.accessoryLoot.remove(at: index)
            player.equipAccessory(accessory, replacing: replacing)
        }
        self.afterLootCollection()
    }
    
    func collectConsumable(id: UUID, player: Player) {
        guard self.canCollect else {
            return
        }
        if let index = self.consumableLoot.firstIndex(where: { $0.id == id }) {
            let consumables = self.consumableLoot.remove(at: index)
            player.addConsumable(consumables)
        }
        self.afterLootCollection()
    }
    
    func collectGold(player: Player) {
        guard self.canCollect else {
            return
        }
        player.modifyGoldAdjusted(by: self.goldLoot)
        self.goldLoot = 0
        self.afterLootCollection()
    }
    
}
