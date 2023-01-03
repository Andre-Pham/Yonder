//
//  WeaponDurabilityPillTests.swift
//  WeaponTests
//
//  Created by Andre Pham on 27/8/2022.
//

import XCTest
@testable import yonder

class WeaponDurabilityPillTests: XCTestCase {
    
    let testSession = TestSession.instance // Begin test session
    
    // MARK: - Basic

    func testDecrementDurabilityPill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5, decrementBy: 2))
        // Test setup
        XCTAssertEqual(weapon.remainingUses, 5)
        XCTAssertFalse(weapon.infiniteRemainingUses)
        // Test logic
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, 3)
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, 1)
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, -1)
    }
    
    func testInfiniteDurabilityPill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
        // Test setup
        XCTAssertGreaterThan(weapon.remainingUses, 0)
        XCTAssertTrue(weapon.infiniteRemainingUses)
        // Test logic
        let durability = weapon.remainingUses
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, durability)
    }
    
    func testDullingDurabilityPill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 75), durabilityPill: DullingDurabilityPill(damageLostPerUse: 25))
        // Test setup
        XCTAssertGreaterThan(weapon.remainingUses, 0)
        XCTAssertTrue(weapon.infiniteRemainingUses)
        // Test logic
        let durability = weapon.remainingUses
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, durability)
        XCTAssertEqual(weapon.damage, 50)
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertEqual(weapon.remainingUses, durability)
        XCTAssertEqual(weapon.damage, 25)
        weapon.use(owner: NoActor(), opposition: NoActor())
        XCTAssertLessThanOrEqual(weapon.remainingUses, 0)
        XCTAssertEqual(weapon.damage, 0)
    }
    
}
