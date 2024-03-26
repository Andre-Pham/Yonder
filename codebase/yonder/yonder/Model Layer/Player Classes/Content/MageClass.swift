//
//  MageClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class MageClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.mage.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 150, location: location)
        let head = Armor(
            name: Strings("class.mage.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 10,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.mage.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 25,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.mage.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 15,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName = Strings("class.mage.accessory").local
        let accesssory = Accessory(
            name: accessoryName,
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamagePercentBuff(
                    sourceName: accessoryName,
                    direction: .outgoing,
                    duration: nil,
                    damageFraction: 1.2
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accesssory, replacing: nil)
        let weapon = Weapon(
            name: Strings("class.mage.weapon").local,
            description: "",
            basePill: DamageBasePill(damage: 80),
            durabilityPill: DecrementDurabilityPill(durability: 6),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
}
