//
//  WarriorClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class WarriorClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.warrior.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 200, location: location)
        let head = Armor(
            name: "TODO", // TODO: "Warrior's Helmet"
            description: "",
            type: .head,
            armorPoints: 24,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: "TODO", // TODO: "Warrior's Chestplate"
            description: "",
            type: .body,
            armorPoints: 56,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: "TODO", // TODO: "Warrior's Leg Armor"
            description: "",
            type: .legs,
            armorPoints: 40,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let shield = Accessory(
            name: "TODO", // TODO: "Warrior's Tower Shield"
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 15,
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
            name: "TODO", // TODO: "Warrior's Blade"
            description: "",
            basePill: DamageBasePill(damage: 50),
            durabilityPill: DecrementDurabilityPill(durability: 10),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
}
