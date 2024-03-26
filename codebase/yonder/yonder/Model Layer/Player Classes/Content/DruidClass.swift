//
//  DruidClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class DruidClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.druid.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 200, location: location)
        let head = Armor(
            name: Strings("class.druid.headArmor").local,
            description: "",
            type: .head,
            armorPoints: 15,
            armorBuffs: [],
            equipmentPills: []
        )
        let body = Armor(
            name: Strings("class.druid.bodyArmor").local,
            description: "",
            type: .body,
            armorPoints: 40,
            armorBuffs: [],
            equipmentPills: []
        )
        let legs = Armor(
            name: Strings("class.druid.legsArmor").local,
            description: "",
            type: .legs,
            armorPoints: 25,
            armorBuffs: [],
            equipmentPills: []
        )
        player.equipArmor(head)
        player.equipArmor(body)
        player.equipArmor(legs)
        let accessoryName = Strings("class.druid.accessory").local
        let accesssory = Accessory(
            name: accessoryName,
            description: "",
            type: .peripheral,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [
                HealthRestorationPercentBuff(
                    sourceName: accessoryName,
                    direction: .incoming,
                    duration: nil,
                    healthFraction: 1.2
                )
            ],
            equipmentPills: []
        )
        player.equipAccessory(accesssory, replacing: nil)
        let weapon1 = Weapon(
            name: Strings("class.druid.weapon1").local,
            description: "",
            basePill: DamageBasePill(damage: 50),
            durabilityPill: DecrementDurabilityPill(durability: 10),
            effectPills: [],
            buffPills: []
        )
        let weapon2 = Weapon(
            name: Strings("class.druid.weapon2").local,
            description: "",
            basePill: HealthRestorationBasePill(healthRestoration: 70),
            durabilityPill: DecrementDurabilityPill(durability: 4),
            effectPills: [],
            buffPills: []
        )
        player.addWeapon(weapon1)
        player.addWeapon(weapon2)
        return player
    }
    
}
