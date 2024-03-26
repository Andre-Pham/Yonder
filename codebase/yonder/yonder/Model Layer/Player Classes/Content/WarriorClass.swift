//
//  WarriorClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class WarriorClass: PlayerClass {
    
    init() {
        super.init(
            name: Strings("class.warrior.name").local,
            characterSprite: YonderImages.warriorClassCharacter
        )
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 250, location: location)
        let head = Armor(
            name: Strings("class.warrior.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 15,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.warrior.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 40,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.warrior.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 25,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName = Strings("class.warrior.accessory").local
        let accesssory = Accessory(
            name: accessoryName,
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamagePercentBuff(
                    sourceName: accessoryName,
                    direction: .incoming,
                    duration: nil,
                    damageFraction: 0.85
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accesssory, replacing: nil)
        let weapon = Weapon(
            name: Strings("class.warrior.weapon").local,
            description: "",
            basePill: DamageBasePill(damage: 60),
            durabilityPill: DecrementDurabilityPill(durability: 8),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
}
