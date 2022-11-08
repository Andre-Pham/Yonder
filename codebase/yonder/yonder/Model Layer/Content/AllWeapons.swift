//
//  AllWeapons.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

enum Weapons {
    
    static func damageWeapon(profile: WeaponProfile, stage: Int) -> Weapon {
        let targetDamage = 100.0.compound(multiply: 1.2, index: stage).toRoundedInt()
        let weaponDamage = Random.selectFromNormalDistribution(mid: targetDamage, boundFraction: 0.5).nearest(5)
        let weaponDurability = Random.selectFromNormalDistribution(min: 3, max: 7)
        return Weapon(
            name: profile.weaponName,
            description: profile.weaponDescription,
            basePill: DamageBasePill(damage: weaponDamage),
            durabilityPill: DecrementDurabilityPill(durability: weaponDurability, decrementBy: 1),
            effectPills: [],
            buffPills: []
        )
    }
    
}
