//
//  ArmorTests.swift
//  ModelTests
//
//  Created by Andre Pham on 8/12/2022.
//

import XCTest
@testable import yonder

final class ArmorTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    
    func testArmorPoints() throws {
        let armor = Armor(name: "", description: "", type: .body, armorPoints: 100, armorBuffs: [], equipmentPills: [])
        self.player.equipArmor(armor)
        XCTAssertEqual(self.player.armorPoints, 100)
        XCTAssertEqual(self.player.maxArmorPoints, 100)
        self.player.bodyArmor.adjustArmorPoints(by: 100)
        XCTAssertEqual(self.player.armorPoints, 200)
        XCTAssertEqual(self.player.maxArmorPoints, 200)
    }

}
