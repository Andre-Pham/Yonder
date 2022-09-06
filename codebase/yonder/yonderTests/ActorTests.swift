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

}
