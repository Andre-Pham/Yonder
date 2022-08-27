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
    @DidSetPublished private(set) var potionLoot = [PotionAbstract]()
    @DidSetPublished private(set) var accessoryLoot = [Accessory]()
    @DidSetPublished private(set) var goldLoot: Int = 0
    private(set) var name: String
    var description: String {
        var components = [String]()
        if !self.armorLoot.isEmpty {
            components.append(
                Strings.DotPoint.local
                    .continuedBy(Strings.Loot.Category.Armors.local).rightPadded(by: ":")
                    .continuedBy(String(self.armorLoot.count))
            )
        }
        if !self.accessoryLoot.isEmpty {
            components.append(
                Strings.DotPoint.local
                    .continuedBy(Strings.Loot.Category.Accessories.local).rightPadded(by: ":")
                    .continuedBy(String(self.accessoryLoot.count))
            )
        }
        if !self.weaponLoot.isEmpty {
            components.append(
                Strings.DotPoint.local
                    .continuedBy(Strings.Loot.Category.Weapons.local).rightPadded(by: ":")
                    .continuedBy(String(self.weaponLoot.count))
            )
        }
        if !self.potionLoot.isEmpty {
            var count = 0
            self.potionLoot.forEach({ count += $0.potionCount })
            components.append(
                Strings.DotPoint.local
                    .continuedBy(Strings.Loot.Category.Potions.local).rightPadded(by: ":")
                    .continuedBy(String(count))
            )
        }
        if self.goldLoot > 0 {
            components.append(
                Strings.DotPoint.local
                    .continuedBy(Strings.Loot.Category.Gold.local).rightPadded(by: ":")
                    .continuedBy(String(self.goldLoot).leftPadded(by: Strings.CurrencySymbol.local))
            )
        }
        return components.joined(separator: "\n")
    }
    public let id = UUID()
    
    private static let availableNames: [String] = [
        Strings.Loot.LootBagName.Amber.local,
        Strings.Loot.LootBagName.Violet.local,
        Strings.Loot.LootBagName.Ebony.local,
        Strings.Loot.LootBagName.Rose.local,
        Strings.Loot.LootBagName.Fern.local,
        Strings.Loot.LootBagName.Tangerine.local,
        Strings.Loot.LootBagName.Azure.local,
        Strings.Loot.LootBagName.Sage.local,
        Strings.Loot.LootBagName.Midnight.local,
        Strings.Loot.LootBagName.Cobalt.local,
        Strings.Loot.LootBagName.Scarlet.local,
        Strings.Loot.LootBagName.Sangria.local
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
    
    func addPotionLoot(_ potion: PotionAbstract) {
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
