//
//  TreasurerClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class TreasurerClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.treasurer.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
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
    
}
