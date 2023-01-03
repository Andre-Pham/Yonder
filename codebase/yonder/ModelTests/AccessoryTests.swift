//
//  AccessoryTests.swift
//  ModelTests
//
//  Created by Andre Pham on 8/12/2022.
//

import XCTest
@testable import yonder

final class AccessoryTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    
    func testBonusHealth() throws {
        let accessory = Accessory(name: "", description: "", type: .regular, healthBonus: 100, armorPointsBonus: 0, buffs: [], equipmentPills: [])
        self.player.equipAccessory(accessory, replacing: nil)
        XCTAssertEqual(self.player.health, 600)
        XCTAssertEqual(self.player.maxHealth, 600)
        self.player.accessorySlots.accessories.first!.adjustHealthBonus(by: 100)
        XCTAssertEqual(self.player.health, 700)
        XCTAssertEqual(self.player.maxHealth, 700)
    }
    
    func testArmorPoints() throws {
        let accessory = Accessory(name: "", description: "", type: .regular, healthBonus: 0, armorPointsBonus: 100, buffs: [], equipmentPills: [])
        self.player.equipAccessory(accessory, replacing: nil)
        XCTAssertEqual(self.player.armorPoints, 100)
        XCTAssertEqual(self.player.maxArmorPoints, 100)
        self.player.accessorySlots.accessories.first!.adjustArmorPointBonus(by: 100)
        XCTAssertEqual(self.player.armorPoints, 200)
        XCTAssertEqual(self.player.maxArmorPoints, 200)
    }

}
