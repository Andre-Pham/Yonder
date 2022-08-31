//
//  WeaponBasePillTests.swift
//  WeaponTests
//
//  Created by Andre Pham on 27/8/2022.
//

import XCTest
@testable import yonder

class WeaponBasePillTests: XCTestCase {
    
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: LootOptions(LootBag(), LootBag(), LootBag()))
    
    override func setUp() async throws {
        self.player.damage(for: 150)
    }
    
    // MARK: - Basic

    func testDamageBasePill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertEqual(weapon.damage, 50)
        // Test logic
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 450)
    }
    
    func testHealthRestorationBasePill() throws {
        let weapon = Weapon(basePill: HealthRestorationBasePill(healthRestoration: 50), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertEqual(weapon.healthRestoration, 50)
        // Test logic
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.player.health, 400)
    }
    
    func testEffectBasePill() throws {
        let weapon = Weapon(basePill: EffectBasePill(), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertEqual(weapon.damage, 0)
        XCTAssertEqual(weapon.healthRestoration, 0)
        XCTAssertEqual(weapon.armorPointsRestoration, 0)
    }
    
    func testArmorPointsRestorationBasePill() throws {
        let weapon = Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 50), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertEqual(weapon.armorPointsRestoration, 50)
        // Test logic
        self.player.addWeapon(weapon)
        self.player.equipArmor(Armor(name: "Armor", description: "Armor.", type: .body, armorPoints: 100, basePurchasePrice: 0, armorBuffs: [], equipmentPills: []))
        self.player.damage(for: 100)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.player.armorPoints, 50)
    }
    
    func testLifestealBasePill() throws {
        let weapon = Weapon(basePill: LifestealBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertEqual(weapon.damage, 50)
        XCTAssertEqual(weapon.healthRestoration, 50)
        // Test logic
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 450)
        XCTAssertEqual(self.player.health, 400)
        weapon.setDamage(to: 5)
        XCTAssertEqual(weapon.healthRestoration, 5)
        weapon.setHealthRestoration(to: 20)
        XCTAssertEqual(weapon.healthRestoration, 5)
    }
    
     // MARK: - Interactions
    
    func testLifestealWithDulling() throws {
        let weapon = Weapon(basePill: LifestealBasePill(damage: 100), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50))
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 400)
        XCTAssertEqual(self.player.health, 450)
    }

}