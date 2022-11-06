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
        lootBag1.addArmorLoot(Armor(name: "Armor Loot", description: "Some weak armor.", type: .legs, armorPoints: 200, armorBuffs: [DamageBuff(sourceName: "Armor Loot", direction: .outgoing, duration: nil, damageDifference: 5)], equipmentPills: []))
        let lootBag2 = LootBag()
        lootBag2.addPotionLoot(DamagePotion(tier: .I, potionCount: 4))
        lootBag2.addPotionLoot(HealthRestorationPotion(tier: .V, potionCount: 4))
        let lootBag3 = LootBag()
        lootBag3.addWeaponLoot(Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DecrementDurabilityPill(durability: 5), effectPills: [LifestealEffectPill(lifestealFraction: 0.5)]))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Loot", description: "This is some spooky armor.", type: .regular, healthBonus: 100, armorPointsBonus: 0, buffs: [], equipmentPills: []))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Peri Loot", description: "This is some scary armor.", type: .peripheral, healthBonus: 0, armorPointsBonus: 100, buffs: [], equipmentPills: []))
        
        return Foe(
            maxHealth: 200,
            weapon: BaseAttack(damage: 100),
            loot: LootOptions(lootBag1, lootBag2, lootBag3)
        )
    }
    
    static func newRegularFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 200.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 75.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let foeHealth = Random.selectFromNormalDistribution(mid: targetHealth, boundFraction: 0.25).nearest(10)
        let foeDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.33).nearest(5)
        return RegularFoe(
            name: profile.foeName,
            description: profile.foeDescription,
            maxHealth: foeHealth,
            damage: foeDamage,
            loot: loot
        )
    }
    
    static func newRegularTankFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 400.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 25.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let foeHealth = Random.selectFromNormalDistribution(mid: targetHealth, boundFraction: 0.2).nearest(10)
        let foeDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.35).nearest(5)
        return RegularFoe(
            name: profile.foeName,
            description: profile.foeDescription,
            maxHealth: foeHealth,
            damage: foeDamage,
            loot: loot
        )
    }
    
    static func newRegularGlassCannonFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 75.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 150.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let foeHealth = Random.selectFromNormalDistribution(mid: targetHealth, boundFraction: 0.33)
        let foeDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.33)
        return RegularFoe(
            name: profile.foeName,
            description: profile.foeDescription,
            maxHealth: foeHealth,
            damage: foeDamage,
            loot: loot
        )
    }
    
    static func newGoblinFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 150.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 100.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let targetGold = 85.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let foeHealth = Random.selectFromNormalDistribution(mid: targetHealth, boundFraction: 0.2)
        let foeDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.35)
        let foeGold = Random.selectFromNormalDistribution(mid: targetGold, boundFraction: 0.35)
        return GoblinFoe(
            name: profile.foeName,
            description: profile.foeDescription,
            maxHealth: foeHealth,
            goldPerSteal: foeGold,
            damage: foeDamage,
            loot: loot
        )
    }
    
    static func newBruteFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 300.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 50.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let foeHealth = Random.selectFromNormalDistribution(mid: targetHealth, boundFraction: 0.18)
        let foeDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.2)
        return BruteFoe(
            name: profile.foeName,
            description: profile.foeDescription,
            maxHealth: foeHealth,
            damage: foeDamage,
            loot: loot
        )
    }
    
}
