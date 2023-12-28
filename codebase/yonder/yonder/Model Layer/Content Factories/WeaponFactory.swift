//
//  WeaponFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponFactory: BuildTokenFactory {
    
    enum BuildToken: String {
        case damageWeapon
        case acuteDamageWeapon
        case obtuseDamageWeapon
        case healthRestorationWeapon
        case acuteHealthRestorationWeapon
        case armorRestorationWeapon
        case acuteArmorRestorationWeapon
        case dullingDamageWeapon
        case copyAttackWeapon
        case lifestealWeapon
        case burnWeapon
        case restorationAndDamageWeapon
        case growingDamageWeapon
        case damageRestorationSwapWeapon
        case consumeAttackWeapon
        case consumeAttackDullingWeapon
        case explosiveWeapon
        case armorToDamageWeapon
    }

    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let weaponProfileBucket: WeaponProfileBucket
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: WeaponProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.weaponProfileBucket = profileBucket
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 damage weapons, etc., in a row
        newTokens.populate(count: 18, { .damageWeapon })
        newTokens.populate(count: 10, { .acuteDamageWeapon })
        newTokens.populate(count: 5, { .obtuseDamageWeapon })
        newTokens.populate(count: 10, { .healthRestorationWeapon })
        newTokens.populate(count: 5, { .acuteHealthRestorationWeapon })
        newTokens.populate(count: 10, { .armorRestorationWeapon })
        newTokens.populate(count: 5, { .acuteArmorRestorationWeapon })
        newTokens.populate(count: 10, { .dullingDamageWeapon })
        newTokens.populate(count: 2, { .copyAttackWeapon })
        newTokens.populate(count: 10, { .lifestealWeapon })
        newTokens.populate(count: 5, { .burnWeapon })
        newTokens.populate(count: 5, { .restorationAndDamageWeapon })
        newTokens.populate(count: 5, { .growingDamageWeapon })
        newTokens.populate(count: 2, { .damageRestorationSwapWeapon })
        newTokens.populate(count: 2, { .consumeAttackWeapon })
        newTokens.populate(count: 2, { .consumeAttackDullingWeapon })
        newTokens.populate(count: 3, { .explosiveWeapon })
        newTokens.populate(count: 2, { .armorToDamageWeapon })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createWeapon() -> Weapon {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .damageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.damageWeapon, tag: .damage)
        case .acuteDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.acuteDamageWeapon, tag: .damage)
        case .obtuseDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.obtuseDamageWeapon, tag: .damage)
        case .healthRestorationWeapon:
            return self.createWeaponWithSpecs(method: Weapons.healthRestorationWeapon, tag: .healthRestoration)
        case .acuteHealthRestorationWeapon:
            return self.createWeaponWithSpecs(method: Weapons.acuteHealthRestorationWeapon, tag: .healthRestoration)
        case .armorRestorationWeapon:
            return self.createWeaponWithSpecs(method: Weapons.armorRestorationWeapon, tag: .armorPointsRestoration)
        case .acuteArmorRestorationWeapon:
            return self.createWeaponWithSpecs(method: Weapons.acuteArmorRestorationWeapon, tag: .armorPointsRestoration)
        case .dullingDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.dullingDamageWeapon, tag: .damage)
        case .copyAttackWeapon:
            return self.createWeaponWithSpecs(method: Weapons.copyAttackWeapon, tag: .consumesFoe)
        case .lifestealWeapon:
            return self.createWeaponWithSpecs(method: Weapons.lifestealWeapon, tag: .consumesFoe)
        case .burnWeapon:
            return self.createWeaponWithSpecs(method: Weapons.burnWeapon, tag: .collateral)
        case .restorationAndDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.restorationAndDamageWeapon, tag: .damageAndRestoration)
        case .growingDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.growingDamageWeapon, tag: .damage)
        case .damageRestorationSwapWeapon:
            return self.createWeaponWithSpecs(method: Weapons.damageRestorationSwapWeapon, tag: .damageAndRestoration)
        case .consumeAttackWeapon:
            return self.createWeaponWithSpecs(method: Weapons.consumeAttackWeapon, tag: .consumesFoe)
        case .consumeAttackDullingWeapon:
            return self.createWeaponWithSpecs(method: Weapons.consumeAttackDullingWeapon, tag: .consumesFoe)
        case .explosiveWeapon:
            return self.createWeaponWithSpecs(method: Weapons.explosiveWeapon, tag: .collateral)
        case .armorToDamageWeapon:
            return self.createWeaponWithSpecs(method: Weapons.armorToDamageWeapon, tag: .collateral)
        }
    }
    
    private func createWeaponWithSpecs(
        method: (_ profile: WeaponProfile, _ stage: Int) -> Weapon,
        tag: WeaponProfileTag
    ) -> Weapon {
        let profile = self.weaponProfileBucket.grabProfile(
            areaTag: self.regionTags.getTag(),
            weaponTag: tag
        )
        return method(profile, self.stage)
    }
    
    func deliver() -> Weapon {
        return self.createWeapon()
    }
    
    func deliver(count: Int) -> [Weapon] {
        return Array(count: count, populateWith: self.createWeapon())
    }
    
}
