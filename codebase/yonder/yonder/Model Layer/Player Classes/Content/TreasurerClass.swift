//
//  TreasurerClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class TreasurerClass: PlayerClass {
    
    init() {
        super.init(
            name: Strings("class.treasurer.name").local,
            characterSprite: YonderImages.treasurerClassCharacter
        )
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 150, location: location)
        let head = Armor(
            name: Strings("class.treasurer.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 15,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.treasurer.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 35,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.treasurer.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 25,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName1 = Strings("class.treasurer.accessory1").local
        let accesssory1 = Accessory(
            name: accessoryName1,
            description: "",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                GoldPercentBuff(
                    sourceName: accessoryName1,
                    duration: nil,
                    goldFraction: 1.15
                )
            ],
            equipmentPills: []
        )
        let accessoryName2 = Strings("class.treasurer.accessory2").local
        let accesssory2 = Accessory(
            name: accessoryName2,
            description: "",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                PricePercentBuff(
                    sourceName: accessoryName2,
                    duration: nil,
                    priceFraction: 0.85
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accesssory1, replacing: nil)
        player.equipAccessory(accesssory2, replacing: nil)
        let weapon = Weapon(
            name: Strings("class.treasurer.weapon").local,
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
