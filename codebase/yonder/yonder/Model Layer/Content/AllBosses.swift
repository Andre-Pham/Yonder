//
//  AllBosses.swift
//  yonder
//
//  Created by Andre Pham on 30/11/2022.
//

import Foundation

/// All bosses.
///
/// Bosses are profile-specific and few in number, so trying to mix and match boss profiles to boss methods is unnecessary complication.
/// Each boss method has its own set of profiles to pick from that are method-specific.
/// This is also in charge of designating the loot, to avoid the logistics of matching up the boss' area and stage with loot, and also allowing cool custom loot to be given.
enum Bosses {
    
    static func allBossOptions(boss: Int) -> [Foe] {
        switch boss {
        case 0:
            return [
                Self.generateBoss0()
            ]
        case 1:
            return [
                Self.generateBoss1()
            ]
        case 2:
            return [
                Self.generateBoss2()
            ]
        case 3:
            return [
                Self.generateBoss3()
            ]
        case 4:
            return [
                Self.generateBoss4()
            ]
        case 5:
            return [
                Self.generateBoss5()
            ]
        default:
            fatalError("Bosses haven't been designed up to stage \(boss)")
        }
    }
    
    private static func generateBoss0() -> Foe {
        // Boss 0 gains health after every attack
        let goldAccessoryName = Strings("specialLoot.travelersPocket").local
        let goldAccessory = Accessory(
            name: goldAccessoryName,
            description: "",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [
                GoldAfterTravelEquipmentPill(goldReceived: 35, sourceName: goldAccessoryName)
            ]
        )
        let healthAccessoryName = Strings("specialLoot.travelersNecklace").local
        let healthAccessory = Accessory(
            name: healthAccessoryName,
            description: "",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [
                PermanentHealthAfterTravelEquipmentPill(health: 5, sourceName: healthAccessoryName)
            ]
        )
        let sword = Weapon(
            name: Strings("specialLoot.travelersBlade").local,
            description: "",
            basePill: DamageBasePill(damage: 100),
            durabilityPill: DecrementDurabilityPill(durability: 8),
            effectPills: [
                GrowDamageAfterTravelEffectPill(damageIncrease: 15)
            ],
            buffPills: []
        )
        let lootChoice = LootChoice()
        lootChoice.addAccessoryLoot(goldAccessory)
        lootChoice.addAccessoryLoot(healthAccessory)
        lootChoice.addWeaponLoot(sword)
        return ScaleAttackBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 0", // TODO: Replace with profile
            description: "",
            maxHealth: 400,
            damage: 50,
            damageMultiplier: 1.5,
            lootChoice: lootChoice
        )
    }
    
    private static func generateBoss1() -> Foe {
        // Boss 1 has relatively low attack, but any damage done to health is permanent
        let healthConsumable = MultiplyHealthConsumable(healthFraction: 2.0, amount: 1)
        healthConsumable.setName(to: Strings("specialLoot.enchantedRuby").local)
        let goldConsumable = MultiplyGoldConsumable(goldFraction: 3.0, amount: 1)
        goldConsumable.setName(to: Strings("specialLoot.enchantedGold").local)
        let armorConsumable = MultiplyArmorPointsConsumable(armorPointsFraction: 2.0, amount: 1)
        armorConsumable.setName(to: Strings("specialLoot.enchantedIron").local)
        let lootChoice = LootChoice()
        lootChoice.addConsumableLoot(healthConsumable)
        lootChoice.addConsumableLoot(goldConsumable)
        lootChoice.addConsumableLoot(armorConsumable)
        return PermanentHealthDamageBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 1", // TODO: Replace with profile
            description: "",
            maxHealth: 700,
            damage: 55,
            lootChoice: lootChoice
        )
    }
    
    
    private static func generateBoss2() -> Foe {
        // Boss 2 has high health, but low attack - it's intended to be a resource fight
        let damageConsumableName = Strings("specialLoot.ruthlessBlessing").local
        let damageConsumable = BuffConsumable(
            buff: DamagePercentBuff(
                sourceName: damageConsumableName,
                direction: .outgoing,
                duration: nil,
                damageFraction: 1.2
            ),
            amount: 1
        )
        damageConsumable.setName(to: damageConsumableName)
        let healingConsumableName = Strings("specialLoot.divineBlessing").local
        let healingConsumable = BuffConsumable(
            buff: HealthRestorationPercentBuff(
                sourceName: healingConsumableName,
                direction: .incoming,
                duration: nil,
                healthFraction: 2.0
            ),
            amount: 1
        )
        healingConsumable.setName(to: healingConsumableName)
        let resistanceConsumableName = Strings("specialLoot.protectiveBlessing").local
        let resistanceConsumable = BuffConsumable(
            buff: DamagePercentBuff(
                sourceName: resistanceConsumableName,
                direction: .incoming,
                duration: nil,
                damageFraction: 0.8
            ),
            amount: 1
        )
        resistanceConsumable.setName(to: resistanceConsumableName)
        let lootChoice = LootChoice()
        lootChoice.addConsumableLoot(damageConsumable)
        lootChoice.addConsumableLoot(healingConsumable)
        lootChoice.addConsumableLoot(resistanceConsumable)
        return RegularBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 2", // TODO: Replace with profile
            description: "",
            maxHealth: 2000,
            damage: 25,
            lootChoice: lootChoice
        )
    }
    
    private static func generateBoss3() -> Foe {
        // Boss 3's every third attack deals extra damage, ALSO, any damage they do to the player's health is restored to them
        let headArmorName = Strings("specialLoot.rugtankHelmet").local
        let headArmor = Armor(
            name: headArmorName,
            description: "",
            type: .head,
            armorPoints: 400,
            armorBuffs: [DamageBuff(sourceName: headArmorName, direction: .incoming, duration: nil, damageDifference: -30)],
            equipmentPills: []
        )
        let bodyArmorName = Strings("specialLoot.rugtankBody").local
        let bodyArmor = Armor(
            name: bodyArmorName,
            description: "",
            type: .body,
            armorPoints: 400,
            armorBuffs: [DamageBuff(sourceName: bodyArmorName, direction: .outgoing, duration: nil, damageDifference: 30)],
            equipmentPills: []
        )
        let legsArmor = Armor(
            name: Strings("specialLoot.rugtankLegs").local,
            description: "",
            type: .legs,
            armorPoints: 800,
            armorBuffs: [],
            equipmentPills: []
        )
        let lootChoice = LootChoice()
        lootChoice.addArmorLoot(headArmor)
        lootChoice.addArmorLoot(bodyArmor)
        lootChoice.addArmorLoot(legsArmor)
        return BigSwingHealBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 3", // TODO: Replace with profile
            description: "",
            maxHealth: 550,
            damagesToCycleThrough: [50, 50, 250],
            lootChoice: lootChoice
        )
    }
    
    
    private static func generateBoss4() -> Foe {
        // Boss 4 disables all healing
        let yonderPotions = MaxRestorationPotion(potionCount: 8)
        let healthConsumable = MultiplyHealthConsumable(healthFraction: 2.0, amount: 1)
        healthConsumable.setName(to: Strings("specialLoot.bottleOfYonder").local)
        let lootChoice = LootChoice()
        lootChoice.addPotionLoot(yonderPotions)
        lootChoice.addConsumableLoot(healthConsumable)
        return DisableHealingBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 4", // TODO: Replace with profile
            description: "",
            maxHealth: 650,
            damage: 75,
            lootChoice: lootChoice
        )
    }
    
    private static func generateBoss5() -> Foe {
        // For boss 5, all damage they take is converted into attack damage
        // HealthToAttackBoss
        return HealthToAttackBoss(
            contentID: nil, // TODO: Replace with profile
            name: "BOSS 5", // TODO: Replace with profile
            description: "",
            maxHealth: 1000,
            damage: 1,
            conversionFraction: 1.0,
            lootChoice: LootChoice() // Last boss - no loot choice needed!
        )
    }
    
}
