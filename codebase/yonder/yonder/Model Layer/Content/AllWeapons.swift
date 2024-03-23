//
//  AllWeapons.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

/// Weapon content.
/// "acute" prefix indicates that durability is sacrificed for high stats.
/// "obtuse" prefix indicates that stats are sacrificed for high durability.
enum Weapons {
    
    // 01
    static func damageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 70, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 5, max: 8).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 02
    static func acuteDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 200, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 2, max: 3).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 03
    static func obtuseDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 8, max: 10).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 04
    static func healthRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let health = WeaponStatRange(target: 120, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 5).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: HealthRestorationBasePill(healthRestoration: health),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 05
    static func acuteHealthRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let health = WeaponStatRange(target: 200, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 2, max: 3).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: HealthRestorationBasePill(healthRestoration: health),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 06
    static func armorRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let armorPoints = WeaponStatRange(target: 120, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 5).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: armorPoints),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 07
    static func acuteArmorRestorationWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let armorPoints = WeaponStatRange(target: 200, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 2, max: 3).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: armorPoints),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 08
    static func dullingDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 180, boundFraction: 0.3).select(compoundMultiplier: 1.2, stage: stage)
        let damageDulling = WeaponStatRange(target: 25, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DullingDurabilityPill(damageLostPerUse: damageDulling),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 09
    static func copyAttackWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 60, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 6).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                CopyAttackEffectPill()
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 10
    static func lifestealWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 70, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let lifestealFraction: Double = StatRange(min: 0.25, max: 1.0).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                LifestealEffectPill(lifestealFraction: lifestealFraction)
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 11
    static func burnWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let tickDamage = WeaponStatRange(target: 20, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let duration: Int = StatRange(min: 2, max: 4).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                BurnStatusEffectEffectPill(tickDamage: tickDamage, duration: duration)
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 12
    static func restorationAndDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let restoration = WeaponStatRange(target: 55, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageAndRestorationBasePill(damage: damage, restoration: restoration),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [],
            buffPills: []
        )
        return weapon
    }
    
    // 13
    static func growingDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 30, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage).nearest(5)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let damageIncrease = WeaponStatRange(target: 20, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage).nearest(5)
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                GrowDamageEffectPill(damageIncrease: damageIncrease)
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 14
    static func damageRestorationSwapWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 110, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 4, max: 7).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                DamageRestorationSwapEffectPill()
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 15
    static func consumeAttackWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 25, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 6).selectFromNormalDistribution()
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                ConsumeAttackEffectPill()
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 16
    static func consumeAttackDullingWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 50, boundFraction: 0.2).select(compoundMultiplier: 1.2, stage: stage)
        let damageDulling = WeaponStatRange(target: 35, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DullingDurabilityPill(damageLostPerUse: damageDulling),
            effectPills: [
                ConsumeAttackEffectPill()
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 17
    static func explosiveWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let damage = WeaponStatRange(target: 300, boundFraction: 0.25).select(compoundMultiplier: 1.2, stage: stage)
        let durability: Int = StatRange(min: 3, max: 4).selectFromNormalDistribution()
        let selfDamage = WeaponStatRange(target: 60, boundFraction: 0.5).select(compoundMultiplier: 1.2, stage: stage)
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                SelfDamageEffectPill(damage: selfDamage)
            ],
            buffPills: []
        )
        return weapon
    }
    
    // 18
    static func armorToDamageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let durability = Int.random(in: 3...4)
        let weapon = Weapon(
            name: profile.weaponName,
            description: "",
            basePill: EffectBasePill(),
            durabilityPill: DecrementDurabilityPill(durability: durability),
            effectPills: [
                ArmorToDamageEffectPill()
            ],
            buffPills: []
        )
        return weapon
    }
    
}

fileprivate class WeaponStatRange: StatRange {
    
    func select(compoundMultiplier: Double, stage: Int) -> Int {
        self.compound(multiply: compoundMultiplier, index: stage)
        return self.selectFromNormalDistribution()
    }
    
}
