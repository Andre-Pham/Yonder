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
    
    // MARK: - Boss 0 Options
    
    static func allBossOptions(boss: Int) -> [Foe] {
        // TODO: Add custom loot
        let lootOptions = LootOptions(LootBag(), LootBag(), LootBag())
        lootOptions.lootBags.forEach({ $0.addGoldLoot(2000*boss) })
        switch boss {
        case 0:
            return [
                Self.generateBoss0()
            ]
        case 1:
            return [
                Self.generateBoss1()
            ]
        // TODO: Add remaining cases
        default:
            return [Self.testBoss()]
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
                GrowDamageEffectPill(damageIncrease: 15)
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
    
    /*
    private static func generateBoss3() -> Foe {
        // Boss 3's every third attack deals extra damage, ALSO, any damage they do to the player's health is restored to them
        // BigSwingHealBoss
    }
    
    private static func generateBoss4() -> Foe {
        // Boss 4 disables all healing
        // DisableHealingBoss
    }
    
    private static func generateBoss5() -> Foe {
        // For boss 5, all damage they take is converted into attack damage
        // HealthToAttackBoss
    }
     */
    
    // Stage 0: gains attack after every attack
    // Stage 1: low-ish attack, but damage is permanent to health
    // Stage 2: high health, low attack
    // Stage 3: every third attack is massive + any damage done to your health heals them | Create an effect pill that cycles between an array of damages (I think that's the best approach)
    // Stage 4: disables healing | NOTE: I should just apply a universal healing buff, but make it 0% instead of like 110%
    // Stage 5: all damage taken becomes attack
    
    // TODO: Remove
    private static func testBoss() -> Foe {
        let randomProfile = RandomProfile(prefix: "Boss")
        let lootChoice = LootChoice()
        lootChoice.addGoldLoot(100)
        lootChoice.addPotionLoot(DamagePotion(tier: .I, potionCount: 5))
        lootChoice.addPotionLoot(DamagePotion(tier: .IV, potionCount: 5))
        return HealthToAttackBoss(
            contentID: nil,
            name: randomProfile.name,
            description: randomProfile.description,
            maxHealth: 200,
            damage: 200,
            conversionFraction: 1.0,
            lootChoice: lootChoice
        )
    }
    
    // TODO: This should probably go somewhere else and be in the same system as the content manager
    // TODO: Or more realistically, many of these methods should go into the content manager
    // TODO: IDK we'll see how the implementation looks like and move things around as necessary
//    private static func getBossProfile(regionProfileTag: RegionProfileTag) -> FoeProfileTag {
//        
//    }
    
}
