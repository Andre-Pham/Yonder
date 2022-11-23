//
//  AllWeapons.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

/// Weapons content.
/// "acute" prefix indicates that durability is sacrificed for high stats.
/// "obtuse" prefix indicates that stats are sacrificed for high durability.
enum Weapons {
    
    // 01
    static func damageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 100, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 02
    static func acuteDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 250, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 1, max: 3).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 03
    static func obtuseDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 5, max: 9).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 04
    static func healthRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let health = WeaponStatRange(target: 150, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: HealthRestorationBasePill(healthRestoration: health),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 05
    static func acuteHeathRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let health = WeaponStatRange(target: 300, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 1, max: 3).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: HealthRestorationBasePill(healthRestoration: health),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 06
    static func armorRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let armorPoints = WeaponStatRange(target: 150, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: armorPoints),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 07
    static func acuteHealthRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let armorPoints = WeaponStatRange(target: 300, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 1, max: 3).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: armorPoints),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 08
    static func dullingDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 220, boundFraction: 0.3).select(compoundMultiplier: 1.2, stage: stage)
        let damageDulling = WeaponStatRange(target: 20, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DullingDurabilityPill(damageLostPerUse: damageDulling),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 09
    static func copyAttackWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 60, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                CopyAttackEffectPill()
            ],
            buffPills: []
        )
    }
    
    // 10
    static func lifestealWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 75, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 5).selectFromNormalDistribution()
        let lifestealFraction: Double = StatRange(min: 0.25, max: 1.0).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                LifestealEffectPill(lifestealFraction: lifestealFraction)
            ],
            buffPills: []
        )
    }
    
    // 11
    static func burnWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 60, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        let tickDamage = WeaponStatRange(target: 20, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let duration: Int = StatRange(min: 3, max: 5).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                BurnStatusEffectEffectPill(tickDamage: tickDamage, duration: duration)
            ],
            buffPills: []
        )
    }
    
    // 12
    static func restorationAndDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 65, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let restoration = WeaponStatRange(target: 65, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 7).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageAndRestorationBasePill(damage: damage, restoration: restoration),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
    }
    
    // 13
    static func growingDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 40, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage).nearest(5)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let damageIncrease = WeaponStatRange(target: 20, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage).nearest(5)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                GrowDamageEffectPill(damageIncrease: damageIncrease)
            ],
            buffPills: []
        )
    }
    
    // 14
    static func damageRestorationSwapWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 150, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 4, max: 8).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                DamageRestorationSwapEffectPill()
            ],
            buffPills: []
        )
    }
    
    // 15
    static func consumeAttackWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 25, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 5).selectFromNormalDistribution()
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                ConsumeAttackEffectPill()
            ],
            buffPills: []
        )
    }
    
    // 16
    static func consumeAttackDullingWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.2).select(compoundMultiplier: 1.2, stage: stage)
        let damageDulling = WeaponStatRange(target: 40, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DullingDurabilityPill(damageLostPerUse: damageDulling),
            effectPills: [
                ConsumeAttackEffectPill()
            ],
            buffPills: []
        )
    }
    
    // 17
    static func explosiveWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 300, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 1, max: 3).selectFromNormalDistribution()
        let selfDamage = WeaponStatRange(target: 60, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                SelfDamageEffectPill(damage: selfDamage)
            ],
            buffPills: []
        )
    }
    
    // 18
    static func armorToDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let durability = Int.random(in: 1...2)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: EffectBasePill(),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                ArmorToDamageEffectPill()
            ],
            buffPills: []
        )
    }
    
}

fileprivate class WeaponStatRange: StatRange {
    
    func select(compoundMultiplier: Double, stage: Int) -> Int {
        self.compound(multiply: compoundMultiplier, index: stage)
        return self.selectFromNormalDistribution()
    }
    
}
