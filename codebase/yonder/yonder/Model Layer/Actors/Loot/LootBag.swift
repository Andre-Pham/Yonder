//
//  LootBag.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LootBag: Storable {
    
    @DidSetPublished private(set) var armorLoot = [Armor]()
    @DidSetPublished private(set) var weaponLoot = [Weapon]()
    @DidSetPublished private(set) var potionLoot = [Potion]()
    @DidSetPublished private(set) var accessoryLoot = [Accessory]()
    @DidSetPublished private(set) var consumableLoot = [Consumable]()
    @DidSetPublished private(set) var goldLoot: Int = 0
    /// The total value in gold of everything in the loot bag
    var totalValue: Int {
        var sum = 0
        self.armorLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.weaponLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.potionLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.accessoryLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.consumableLoot.forEach({ sum += $0.getBasePurchasePrice() })
        sum += self.goldLoot
        return sum
    }
    /// The total number of entities in the loot bag that can be looted
    var optionCount: Int {
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
    private(set) var name: String
    var description: String {
        var components = [String]()
        if !self.armorLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.armors").local).rightPadded(by: ":")
                    .continuedBy(String(self.armorLoot.count))
            )
        }
        if !self.accessoryLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.accessories").local).rightPadded(by: ":")
                    .continuedBy(String(self.accessoryLoot.count))
            )
        }
        if !self.weaponLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.weapons").local).rightPadded(by: ":")
                    .continuedBy(String(self.weaponLoot.count))
            )
        }
        if !self.consumableLoot.isEmpty {
            var count = 0
            self.consumableLoot.forEach({ count += $0.remainingUses })
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.consumables").local).rightPadded(by: ":")
                    .continuedBy(String(count))
            )
        }
        if !self.potionLoot.isEmpty {
            var count = 0
            self.potionLoot.forEach({ count += $0.potionCount })
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.potions").local).rightPadded(by: ":")
                    .continuedBy(String(count))
            )
        }
        if self.goldLoot > 0 {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.gold").local).rightPadded(by: ":")
                    .continuedBy(String(self.goldLoot).leftPadded(by: Strings("currencySymbol").local))
            )
        }
        return components.joined(separator: "\n")
    }
    public let id = UUID()
    
    private static let availableNames: [String] = [
        Strings("loot.lootBagName.amber").local,
        Strings("loot.lootBagName.violet").local,
        Strings("loot.lootBagName.ebony").local,
        Strings("loot.lootBagName.rose").local,
        Strings("loot.lootBagName.fern").local,
        Strings("loot.lootBagName.tangerine").local,
        Strings("loot.lootBagName.azure").local,
        Strings("loot.lootBagName.sage").local,
        Strings("loot.lootBagName.midnight").local,
        Strings("loot.lootBagName.cobalt").local,
        Strings("loot.lootBagName.scarlet").local,
        Strings("loot.lootBagName.sangria").local
    ]
    
    init() {
        self.name = LootBag.availableNames.randomElement()!
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case armorLoot
        case weaponLoot
        case potionLoot
        case accessoryLoot
        case consumableLoot
        case goldLoot
        case name
    }

    required init(dataObject: DataObject) {
        self.armorLoot = dataObject.getObjectArray(Field.armorLoot.rawValue, type: Armor.self)
        self.weaponLoot = dataObject.getObjectArray(Field.weaponLoot.rawValue, type: Weapon.self)
        self.potionLoot = dataObject.getObjectArray(Field.potionLoot.rawValue, type: PotionAbstract.self) as! [any Potion]
        self.accessoryLoot = dataObject.getObjectArray(Field.accessoryLoot.rawValue, type: Accessory.self)
        self.consumableLoot = dataObject.getObjectArray(Field.consumableLoot.rawValue, type: ConsumableAbstract.self) as! [any Consumable]
        self.goldLoot = dataObject.get(Field.goldLoot.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.armorLoot.rawValue, value: self.armorLoot)
            .add(key: Field.weaponLoot.rawValue, value: self.weaponLoot)
            .add(key: Field.potionLoot.rawValue, value: self.potionLoot as [PotionAbstract])
            .add(key: Field.accessoryLoot.rawValue, value: self.accessoryLoot)
            .add(key: Field.consumableLoot.rawValue, value: self.consumableLoot as [ConsumableAbstract])
            .add(key: Field.goldLoot.rawValue, value: self.goldLoot)
            .add(key: Field.name.rawValue, value: self.name)
    }

    // MARK: - Functions
    
    func reassignName(banned: [String] = []) {
        let currentIndex = LootBag.availableNames.firstIndex(of: self.name)!
        var newIndex = (currentIndex + Int.random(in: 1..<LootBag.availableNames.count))%LootBag.availableNames.count
        while banned.contains(where: { $0 == LootBag.availableNames[newIndex] }) {
            newIndex = (newIndex + 1)%LootBag.availableNames.count
        }
        self.name = LootBag.availableNames[newIndex]
    }
    
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
        if let index = self.armorLoot.firstIndex(where: { $0.id == id }) {
            let armor = self.armorLoot.remove(at: index)
            player.equipArmor(armor)
        }
    }
    
    func collectWeapon(id: UUID, player: Player) {
        if let index = self.weaponLoot.firstIndex(where: { $0.id == id }) {
            let weapon = self.weaponLoot.remove(at: index)
            player.addWeapon(weapon)
        }
    }
    
    func collectPotion(id: UUID, player: Player) {
        if let index = self.potionLoot.firstIndex(where: { $0.id == id }) {
            let potions = self.potionLoot.remove(at: index)
            player.addPotion(potions)
        }
    }
    
    func collectAccessory(id: UUID, replacing: UUID?, player: Player) {
        if let index = self.accessoryLoot.firstIndex(where: { $0.id == id }) {
            let accessory = self.accessoryLoot.remove(at: index)
            player.equipAccessory(accessory, replacing: replacing)
        }
    }
    
    func collectConsumable(id: UUID, player: Player) {
        if let index = self.consumableLoot.firstIndex(where: { $0.id == id }) {
            let consumables = self.consumableLoot.remove(at: index)
            player.addConsumable(consumables)
        }
    }
    
    func collectGold(player: Player) {
        player.modifyGoldAdjusted(by: self.goldLoot)
        self.goldLoot = 0
    }
    
}
