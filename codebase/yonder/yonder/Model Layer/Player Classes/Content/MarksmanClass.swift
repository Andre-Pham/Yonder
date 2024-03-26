//
//  MarksmanClass.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import Foundation

class MarksmanClass: PlayerClass {
    
    init() {
        super.init(
            name: Strings("class.marksman.name").local,
            characterSprite: YonderImages.marksmanClassCharacter
        )
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 150, location: location)
        let head = Armor(
            name: Strings("class.marksman.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 10,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.marksman.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 25,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.marksman.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 15,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName = Strings("class.marksman.accessory").local
        let accesssory = Accessory(
            name: accessoryName,
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [
                RestoreAfterKillEquipmentPill(healthRestoration: 50, armorPointsRestoration: 10, sourceName: accessoryName)
            ]
        )
        player.equipAccessory(accesssory, replacing: nil)
        let weapon = Weapon(
            name: Strings("class.marksman.weapon").local,
            description: "",
            basePill: DamageBasePill(damage: 100),
            durabilityPill: DecrementDurabilityPill(durability: 6),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
}
