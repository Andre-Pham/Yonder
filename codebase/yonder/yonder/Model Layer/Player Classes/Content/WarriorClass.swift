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
    
}
