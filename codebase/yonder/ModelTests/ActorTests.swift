//
//  ActorTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class ActorTests: XCTestCase {

    let actor = ActorAbstract(maxHealth: 200)
    
    func testHealth() throws {
        self.actor.damage(for: 50)
        XCTAssertEqual(self.actor.health, 150)
        self.actor.restoreHealth(for: 500)
        XCTAssertEqual(self.actor.health, self.actor.maxHealth)
    }
    
    func testDeath() throws {
        self.actor.damage(for: 199)
        XCTAssertTrue(!self.actor.isDead)
        self.actor.damage(for: 1)
        XCTAssertTrue(self.actor.isDead)
    }
    
    func testMaxHealth() throws {
        XCTAssertEqual(self.actor.health, self.actor.maxHealth)
        self.actor.damage(for: 100)
        XCTAssertEqual(self.actor.maxHealth, 200)
        XCTAssertEqual(self.actor.health, 100)
        self.actor.adjustBonusHealth(by: 100)
        XCTAssertEqual(self.actor.maxHealth, 300)
        XCTAssertEqual(self.actor.health, 200)
    }
    
    func testRestorationAdjusted() throws {
        self.actor.equipArmor(Armor(name: "", description: "", type: .body, armorPoints: 500, basePurchasePrice: 10, armorBuffs: [], equipmentPills: []))
        self.actor.damage(for: 600) // Set to 100/200 health, 0/500 armor
        self.actor.addBuff(HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        self.actor.addBuff(ArmorPointsRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsFraction: 3.0))
        self.actor.restoreAdjusted(sourceOwner: self.actor, using: NoItem(), for: 100)
        // 100 restoration. 50 is required for health since healing is doubled. The remaining 50 is tripled for armor points.
        XCTAssertEqual(self.actor.health, 200)
        XCTAssertEqual(self.actor.armorPoints, 150)
    }
    
    func testEquipArmor() throws {
        let headArmor = Armor(name: "", description: "", type: .head, armorPoints: 100, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        let bodyArmor = Armor(name: "", description: "", type: .body, armorPoints: 200, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        let legsArmor = Armor(name: "", description: "", type: .legs, armorPoints: 300, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        self.actor.equipArmor(headArmor)
        XCTAssertEqual(self.actor.headArmor.armorPoints, headArmor.armorPoints)
        XCTAssertEqual(self.actor.armorPoints, headArmor.armorPoints)
        XCTAssertEqual(self.actor.maxArmorPoints, headArmor.armorPoints)
        self.actor.equipArmor(bodyArmor)
        XCTAssertEqual(self.actor.bodyArmor.armorPoints, bodyArmor.armorPoints)
        XCTAssertEqual(self.actor.armorPoints, headArmor.armorPoints + bodyArmor.armorPoints)
        XCTAssertEqual(self.actor.maxArmorPoints, headArmor.armorPoints + bodyArmor.armorPoints)
        self.actor.damage(for: 250)
        self.actor.equipArmor(legsArmor)
        XCTAssertEqual(self.actor.legsArmor.armorPoints, legsArmor.armorPoints)
        XCTAssertEqual(self.actor.armorPoints, headArmor.armorPoints + bodyArmor.armorPoints + legsArmor.armorPoints - 250)
        XCTAssertEqual(self.actor.maxArmorPoints, headArmor.armorPoints + bodyArmor.armorPoints + legsArmor.armorPoints)
        let replacementArmor = Armor(name: "", description: "", type: .legs, armorPoints: 150, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        self.actor.equipArmor(replacementArmor)
        XCTAssertEqual(self.actor.armorPoints, 450)
        XCTAssertEqual(self.actor.maxArmorPoints, headArmor.armorPoints + bodyArmor.armorPoints + replacementArmor.armorPoints)
    }
    
    func testUnequipArmor() throws {
        let headArmor = Armor(name: "", description: "", type: .head, armorPoints: 500, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        let bodyArmor = Armor(name: "", description: "", type: .body, armorPoints: 500, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        let legsArmor = Armor(name: "", description: "", type: .legs, armorPoints: 500, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [])
        self.actor.equipArmor(headArmor)
        self.actor.equipArmor(bodyArmor)
        self.actor.equipArmor(legsArmor)
        XCTAssertEqual(self.actor.armorPoints, 1500)
        self.actor.unequipArmor(self.actor.headArmor)
        XCTAssertEqual(self.actor.armorPoints, 1000)
        self.actor.damage(for: 800)
        XCTAssertEqual(self.actor.armorPoints, 200)
        self.actor.unequipArmor(self.actor.bodyArmor)
        XCTAssertEqual(self.actor.armorPoints, 200)
        self.actor.unequipArmor(self.actor.legsArmor)
        XCTAssertEqual(self.actor.armorPoints, 0)
    }

}
