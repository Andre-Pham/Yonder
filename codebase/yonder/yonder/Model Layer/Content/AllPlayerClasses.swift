//
//  AllPlayerClasses.swift
//  yonder
//
//  Created by Andre Pham on 6/12/2022.
//

import Foundation

enum PlayerClass  {
    
    case none
    case warrior
    case treasurer
    case alchemist
    case mage
    case warlock
    //case druid
    case cleric
    case paladin
    
    /// Classes that may be selected by the player
    var availableClasses: [PlayerClass] {
        [.warrior, .treasurer, .alchemist]
    }
    
    func createPlayer(at location: Location) -> Player {
        switch self {
        case .none:
            return Player(maxHealth: 500, location: location)
        case .warrior:
            return Self.warrior(at: location)
        case .treasurer:
            return Self.treasurer(at: location)
        case .alchemist:
            return Self.alchemist(at: location)
        case .mage:
            return Self.mage(at: location)
        case .warlock:
            return Self.warlock(at: location)
        case .cleric:
            return Self.cleric(at: location)
        case .paladin:
            return Self.paladin(at: location)
        }
    }
    
    private static func warrior(at location: Location) -> Player {
        let player = Player(maxHealth: 300, location: location)
        let body = Armor(
            name: "TODO", // "Warrior's Chestplate"
            description: "TODO",
            type: .body,
            armorPoints: 200,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(body)
        let shield = Accessory(
            name: "TODO", // "Tower Shield"
            description: "TODO", // "A tall sturdy shield forged of iron and wood"
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 50,
            buffs: [
                DamagePercentBuff(
                    sourceName: "TODO",
                    direction: .incoming,
                    duration: nil,
                    damageFraction: 0.85
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(shield, replacing: nil)
        let weapon = Weapon(
            name: "TODO", // "Iron Sword"
            description: "TODO", // "A standard blade of forged iron"
            basePill: DamageBasePill(damage: 50),
            durabilityPill: DecrementDurabilityPill(durability: 10),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
    private static func treasurer(at location: Location) -> Player {
        let player = Player(maxHealth: 200, location: location)
        player.modifyGold(by: 800)
        let legs = Armor(
            name: "TODO", // Deep pocket trousers
            description: "TODO",
            type: .legs,
            armorPoints: 45,
            armorBuffs: [GoldPercentBuff(sourceName: "TODO", duration: nil, goldFraction: 1.2)],
            equipmentPills: []
        )
        player.equipArmor(legs)
        let accessory = Accessory(
            name: "TODO", // Golden timepiece
            description: "TODO",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [PricePercentBuff(sourceName: "TODO", duration: nil, priceFraction: 0.85)],
            equipmentPills: []
        )
        player.equipAccessory(accessory, replacing: nil)
        let weapon = Weapon(
            name: "TODO", // Obsidian Pocketknife
            description: "TODO",
            basePill: DamageBasePill(damage: 100),
            durabilityPill: DecrementDurabilityPill(durability: 6),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
    private static func alchemist(at location: Location) -> Player {
        let player = Player(maxHealth: 200, location: location)
        let head = Armor(
            name: "TODO", // Alchemy hood
            description: "TODO",
            type: .head,
            armorPoints: 45,
            armorBuffs: [
                PotionHealthRestorationPercentBuff(sourceName: "TODO",
                direction: .incoming,
                duration: nil,
                healthFraction: 1.25)
            ],
            equipmentPills: []
        )
        player.equipArmor(head)
        let body = Armor(
            name: "TODO", // Strongwoven Tunic
            description: "TODO",
            type: .body,
            armorPoints: 80,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(body)
        let accessory = Accessory(
            name: "TODO", // Lethal Ingredient Pouch
            description: "TODO", // Enhances potion damage by spiking the mixture
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                PotionDamagePercentBuff(
                    sourceName: "TODO",
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: 1.25
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accessory, replacing: nil)
        player.addPotion(DamagePotion(tier: .III, potionCount: 10))
        player.addPotion(DamagePotion(tier: .V, potionCount: 2))
        player.addPotion(HealthRestorationPotion(tier: .III, potionCount: 4))
        player.addPotion(MaxRestorationPotion(potionCount: 2))
        return player
    }
    
    private static func mage(at location: Location) -> Player {
        let player = Player(maxHealth: 120, location: location)
        // TODO: Implement class
        // Low shields armour that buffs damage
        // tome that deals very high damage
        // potions for healing/damage
        // no accessory
        return player
    }
    
    private static func warlock(at location: Location) -> Player {
        let player = Player(maxHealth: 120, location: location)
        // TODO: Implement class
        // no armour
        // a strong lifesteal weapon
        // accessory that gives damage resistance and damage buff
        return player
    }
    
    private static func cleric(at location: Location) -> Player {
        let player = Player(maxHealth: 300, location: location)
        // TODO: Implement class
        // lots of healing (staff and potions)
        // thorns armour
        // resistance accessory
        return player
    }
    
    private static func paladin(at location: Location) -> Player {
        let player = Player(maxHealth: 450, location: location)
        // TODO: Implement class
        // high health
        // high healing
        // regular weapon
        // phoenix accessory
        return player
    }
    
}
