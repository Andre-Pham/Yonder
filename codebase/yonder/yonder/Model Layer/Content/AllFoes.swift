//
//  AllFoes.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

/// Foe content.
/// "acute" prefix indicates that hit points is sacrificed for high attack.
/// "obtuse" prefix indicates that attack is sacrificed for high hit points.
enum Foes {
    
    // 01
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
    
    // 02
    static func newRegularObtuseFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
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
    
    // 03
    static func newRegularAcuteFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
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
    
    // 04
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
    
    // 05
    static func newGoblinObtuseFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 300.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 50.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let targetGold = 35.0.compound(multiply: 1.2, index: stage).toRoundedInt()
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
    
    // 06
    static func newGoblinAcuteFoe(profile: FoeProfile, stage: Int, loot: LootOptions) -> Foe {
        let targetHealth = 60.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let targetDamage = 180.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let targetGold = 120.0.compound(multiply: 1.2, index: stage).toRoundedInt()
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
    
    // 07
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
