//
//  AllFoes.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

enum Foes {
    
    // MARK: - Test Foes
    
    static func newTestFoe() -> Foe {
        let lootBag1 = LootBag()
        lootBag1.addGoldLoot(500)
        lootBag1.addArmorLoot(Armor(name: "Armor Loot", description: "Some weak armor.", type: .legs, armorPoints: 200, basePurchasePrice: 200, armorBuffs: [DamageBuff(sourceName: "Armor Loot", direction: .outgoing, duration: nil, damageDifference: 5)], equipmentPills: []))
        let lootBag2 = LootBag()
        lootBag2.addPotionLoot(DamagePotion(tier: .I, potionCount: 4, basePurchasePrice: 10))
        lootBag2.addPotionLoot(HealthRestorationPotion(tier: .V, potionCount: 4, basePurchasePrice: 10))
        let lootBag3 = LootBag()
        lootBag3.addWeaponLoot(Weapon(basePill: LifestealBasePill(damage: 100), durabilityPill: DecrementDurabilityPill(durability: 5)))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Loot", description: "This is some spooky armor.", type: .regular, healthBonus: 100, armorPointsBonus: 0, basePurchasePrice: 100, buffs: [], equipmentPills: []))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Peri Loot", description: "This is some scary armor.", type: .peripheral, healthBonus: 0, armorPointsBonus: 100, basePurchasePrice: 100, buffs: [], equipmentPills: []))
        
        return Foe(
            maxHealth: 200,
            weapon: BaseAttack(damage: 100),
            loot: LootOptions(lootBag1, lootBag2, lootBag3)
        )
    }
    
    // MARK:  - Stage 0
    
    
    
}
