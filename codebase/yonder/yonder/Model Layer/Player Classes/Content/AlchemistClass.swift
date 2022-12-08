//
//  AlchemistClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class AlchemistClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.alchemist.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
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
    
}
