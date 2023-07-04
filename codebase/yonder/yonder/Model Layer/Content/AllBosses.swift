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
            //lootOptions.option1.addArmorLoot(<#T##armor: Armor##Armor#>)
            //lootOptions.option2.addWeaponLoot(<#T##weapon: Weapon##Weapon#>)
            //lootOptions.option3.addAccessoryLoot(<#T##accessory: Accessory##Accessory#>)
            return [
                //Self.boss0BigHealth(lootOptions: lootOptions),
                //Self.boss0SelfHeals(lootOptions: lootOptions)
                Self.testBoss()
            ]
        case 1:
            return [
                Self.testBoss()
            ]
        // TODO: Add remaining cases
        default:
            return [Self.testBoss()]
        }
    }
    
    // TODO: Remove
    private static func testBoss() -> Foe {
        let randomProfile = RandomProfile(prefix: "Boss")
        return Foe(
            contentID: nil,
            name: randomProfile.name,
            description: randomProfile.description,
            maxHealth: 1000,
            weapon: BaseAttack(damage: 1000),
            loot: NoLootOptions()
        )
    }
    
//    private static func boss0BigHealth(lootOptions: LootOptions) -> Foe {
//        let profile: BossProfile = [
//            BossProfile(bossName: <#T##String#>, bossDescription: <#T##String#>),
//            BossProfile(bossName: <#T##String#>, bossDescription: <#T##String#>),
//            BossProfile(bossName: <#T##String#>, bossDescription: <#T##String#>)
//        ].randomElement()!
//        return Foe(
//            name: profile.bossName,
//            description: profile.bossDescription,
//            maxHealth: <#T##Int#>,
//            weapon: <#T##Weapon#>,
//            loot: lootOptions
//        )
//    }
//
//    private static func boss0SelfHeals(lootOptions: LootOptions) -> Foe {
//        return
//    }
    
    // MARK: - Boss 1 Options
        
    // MARK: - Boss 2 Options
    
    // MARK: - Boss 3 Options
    
}
