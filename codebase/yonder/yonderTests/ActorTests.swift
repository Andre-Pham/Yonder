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

}
