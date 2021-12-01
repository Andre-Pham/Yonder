//
//  AllWeapons.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

enum Weapons {
    
    // MARK: - Test Weapons
    
    static func newTestBasicWeapon() -> BasicWeapon {
        return BasicWeapon(damage: 100, durability: 5, basePurchasePrice: 100)
    }
    
    static func newTestHealingWeapon() -> HealthRestorationWeapon {
        return HealthRestorationWeapon(healthRestoration: 50, durability: 5, basePurchasePrice: 100)
    }
    
    static func newTestDullingWeapon() -> DullingWeapon {
        return DullingWeapon(damage: 7, damageLostPerUse: 2, basePurchasePrice: 100)
    }
    
}
