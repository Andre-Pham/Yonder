//
//  WeaponPillBoxTests.swift
//  ModelTests
//
//  Created by Andre Pham on 18/9/2022.
//

import XCTest
@testable import yonder

class WeaponPillBoxTests: XCTestCase {

    func testWeak() throws {
        let pill: WeaponDurabilityPill = InfiniteDurabilityPill()
        if true {
            // In narrower scope
            let weapon = Weapon(basePill: DamageBasePill(damage: 5), durabilityPill: pill)
            if weapon.damage > 0 { } // This is literally to suppress the "unused variable" warning
            XCTAssertNotNil(WeaponPillBox.getWeapon(from: pill))
        }
        XCTAssertNil(WeaponPillBox.getWeapon(from: pill))
    }

}
