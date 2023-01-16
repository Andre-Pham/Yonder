//
//  WeaponFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let weaponProfileBucket: WeaponProfileBucket
    private var weaponSupply = [Weapon]()
    private var profilesInUse = [UUID: WeaponProfile]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: WeaponProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.weaponProfileBucket = profileBucket
    }
    
    func recycleProfiles() {
        for profile in self.profilesInUse.values {
            self.weaponProfileBucket.restoreProfile(profile)
        }
    }
    
    private func buildWeapons() {
        var weapons = [Weapon]()
        
        // 01
        self.addWeapon(to: &weapons, method: Weapons.damageWeapon, count: 18, tag: .damage)
        // 02
        self.addWeapon(to: &weapons, method: Weapons.acuteDamageWeapon, count: 10, tag: .damage)
        // 03
        self.addWeapon(to: &weapons, method: Weapons.obtuseDamageWeapon, count: 5, tag: .damage)
        // 04
        self.addWeapon(to: &weapons, method: Weapons.healthRestorationWeapon, count: 10, tag: .healthRestoration)
        // 05
        self.addWeapon(to: &weapons, method: Weapons.acuteHealthRestorationWeapon, count: 5, tag: .healthRestoration)
        // 06
        self.addWeapon(to: &weapons, method: Weapons.armorRestorationWeapon, count: 10, tag: .armorPointsRestoration)
        // 07
        self.addWeapon(to: &weapons, method: Weapons.acuteArmorRestorationWeapon, count: 5, tag: .armorPointsRestoration)
        // 08
        self.addWeapon(to: &weapons, method: Weapons.dullingDamageWeapon, count: 10, tag: .damage)
        // 09
        self.addWeapon(to: &weapons, method: Weapons.copyAttackWeapon, count: 2, tag: .consumesFoe)
        // 10
        self.addWeapon(to: &weapons, method: Weapons.lifestealWeapon, count: 10, tag: .consumesFoe)
        // 11
        self.addWeapon(to: &weapons, method: Weapons.burnWeapon, count: 5, tag: .collateral)
        // 12
        self.addWeapon(to: &weapons, method: Weapons.restorationAndDamageWeapon, count: 5, tag: .damageAndRestoration)
        // 13
        self.addWeapon(to: &weapons, method: Weapons.growingDamageWeapon, count: 5, tag: .damage)
        // 14
        self.addWeapon(to: &weapons, method: Weapons.damageRestorationSwapWeapon, count: 2, tag: .damageAndRestoration)
        // 15
        self.addWeapon(to: &weapons, method: Weapons.consumeAttackWeapon, count: 2, tag: .consumesFoe)
        // 16
        self.addWeapon(to: &weapons, method: Weapons.consumeAttackDullingWeapon, count: 2, tag: .consumesFoe)
        // 17
        self.addWeapon(to: &weapons, method: Weapons.explosiveWeapon, count: 3, tag: .collateral)
        // 18
        self.addWeapon(to: &weapons, method: Weapons.armorToDamageWeapon, count: 2, tag: .collateral)
        
        weapons.shuffle()
        self.weaponSupply.appendToFront(contentsOf: weapons)
    }
    
    private func addWeapon(
        to weapons: inout [Weapon],
        method: (_ profile: WeaponProfile, _ stage: Int) -> Weapon,
        count: Int,
        tag: WeaponProfileTag
    ) {
        weapons.populate(count: count) {
            let profile = self.weaponProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), weaponTag: tag)
            let weapon = method(profile, self.stage)
            self.profilesInUse[weapon.id] = profile
            return weapon
        }
    }
    
    func deliver() -> Weapon {
        if self.weaponSupply.isEmpty {
            self.buildWeapons()
        }
        let weapon = self.weaponSupply.popLast()!
        self.profilesInUse.removeValue(forKey: weapon.id)
        return weapon
    }
    
    func deliver(count: Int) -> [Weapon] {
        let initialCount = self.weaponSupply.count
        while self.weaponSupply.count < count {
            self.buildWeapons()
            assert(initialCount < self.weaponSupply.count, "No weapons being generated - infinite loop")
        }
        let weapons = self.weaponSupply.takeLast(count)
        weapons.forEach({ self.profilesInUse.removeValue(forKey: $0.id) })
        return weapons
    }
    
}
