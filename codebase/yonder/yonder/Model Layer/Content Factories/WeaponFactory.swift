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
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: WeaponProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.weaponProfileBucket = profileBucket
    }
    
    private func buildWeapons() {
        var weapons = [Weapon]()
        
        // 01
        weapons.populate(count: 18) {
            Weapons.damageWeapon(profile: self.getProfile(for: .damage), stage: self.stage)
        }
        // 02
        weapons.populate(count: 10) {
            Weapons.acuteDamageWeapon(profile: self.getProfile(for: .damage), stage: self.stage)
        }
        // 03
        weapons.populate(count: 5) {
            Weapons.obtuseDamageWeapon(profile: self.getProfile(for: .damage), stage: self.stage)
        }
        // 04
        weapons.populate(count: 10) {
            Weapons.healthRestorationWeapon(profile: self.getProfile(for: .healthRestoration), stage: self.stage)
        }
        // 05
        weapons.populate(count: 5) {
            Weapons.acuteHealthRestorationWeapon(profile: self.getProfile(for: .healthRestoration), stage: self.stage)
        }
        // 06
        weapons.populate(count: 10) {
            Weapons.armorRestorationWeapon(profile: self.getProfile(for: .armorPointsRestoration), stage: self.stage)
        }
        // 07
        weapons.populate(count: 5) {
            Weapons.acuteArmorRestorationWeapon(profile: self.getProfile(for: .armorPointsRestoration), stage: self.stage)
        }
        // 08
        weapons.populate(count: 10) {
            Weapons.dullingDamageWeapon(profile: self.getProfile(for: .damage), stage: self.stage)
        }
        // 09
        weapons.populate(count: 2) {
            Weapons.copyAttackWeapon(profile: self.getProfile(for: .consumesFoe), stage: self.stage)
        }
        // 10
        weapons.populate(count: 10) {
            Weapons.lifestealWeapon(profile: self.getProfile(for: .consumesFoe), stage: self.stage)
        }
        // 11
        weapons.populate(count: 5) {
            Weapons.burnWeapon(profile: self.getProfile(for: .collateral), stage: self.stage)
        }
        // 12
        weapons.populate(count: 5) {
            Weapons.restorationAndDamageWeapon(profile: self.getProfile(for: .damageAndRestoration), stage: self.stage)
        }
        // 13
        weapons.populate(count: 5) {
            Weapons.growingDamageWeapon(profile: self.getProfile(for: .damage), stage: self.stage)
        }
        // 14
        weapons.populate(count: 2) {
            Weapons.damageRestorationSwapWeapon(profile: self.getProfile(for: .damageAndRestoration), stage: self.stage)
        }
        // 15
        weapons.populate(count: 2) {
            Weapons.consumeAttackWeapon(profile: self.getProfile(for: .consumesFoe), stage: self.stage)
        }
        // 16
        weapons.populate(count: 2) {
            Weapons.consumeAttackDullingWeapon(profile: self.getProfile(for: .consumesFoe), stage: self.stage)
        }
        // 17
        weapons.populate(count: 3) {
            Weapons.explosiveWeapon(profile: self.getProfile(for: .collateral), stage: self.stage)
        }
        // 18
        weapons.populate(count: 2) {
            Weapons.armorToDamageWeapon(profile: self.getProfile(for: .collateral), stage: self.stage)
        }
        
        weapons.shuffle()
        self.weaponSupply.appendToFront(contentsOf: weapons)
    }
    
    private func getProfile(for tag: WeaponProfileTag) -> WeaponProfile {
        return self.weaponProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), weaponTag: tag)
    }
    
    func deliver() -> Weapon {
        if self.weaponSupply.isEmpty {
            self.buildWeapons()
        }
        return self.weaponSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Weapon] {
        let initialCount = self.weaponSupply.count
        while self.weaponSupply.count < count {
            self.buildWeapons()
            assert(initialCount < self.weaponSupply.count, "No weapons being generated - infinite loop")
        }
        return self.weaponSupply.takeLast(count)
    }
    
}
