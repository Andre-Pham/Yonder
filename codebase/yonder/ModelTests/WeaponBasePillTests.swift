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
    let turnManager = TestsTurnManager.turnManager
    
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
        self.player.equipArmor(Armor(name: "Armor", description: "Armor.", type: .body, armorPoints: 100, armorBuffs: [], equipmentPills: []))
        self.player.damage(for: 100)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.player.armorPoints, 50)
    }

}
