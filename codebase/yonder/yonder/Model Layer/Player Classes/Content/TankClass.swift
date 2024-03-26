//
//  TankClass.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import Foundation

class TankClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.tank.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 200, location: location)
        let head = Armor(
            name: Strings("class.tank.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 35,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.tank.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 100,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.tank.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 65,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName = Strings("class.tank.accessory").local
        let accesssory = Accessory(
            name: accessoryName,
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                DamageBuff(
                    sourceName: accessoryName,
                    direction: .incoming,
                    duration: nil,
                    damageDifference: -15
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accesssory, replacing: nil)
        let weapon = Weapon(
            name: Strings("class.tank.weapon").local,
            description: "",
            basePill: DamageBasePill(damage: 40),
            durabilityPill: DecrementDurabilityPill(durability: 12),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon)
        return player
    }
    
}
