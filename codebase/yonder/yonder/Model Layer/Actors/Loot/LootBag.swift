//
//  LootBag.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LootBag {
    
    @DidSetPublished private(set) var armorLoot = [Armor]()
    @DidSetPublished private(set) var weaponLoot = [Weapon]()
    @DidSetPublished private(set) var potionLoot = [Potion]()
    @DidSetPublished private(set) var accessoryLoot = [Accessory]()
    @DidSetPublished private(set) var goldLoot: Int = 0
    var totalValue: Int {
        var sum = 0
        self.armorLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.weaponLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.potionLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.accessoryLoot.forEach({ sum += $0.getBasePurchasePrice() })
        sum += self.goldLoot
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
    
    func collectGold(player: Player) {
        player.modifyGoldAdjusted(by: self.goldLoot)
        self.goldLoot = 0
    }
    
}
