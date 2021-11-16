//
//  yonderTests.swift
//  yonderTests
//
//  Created by Andre Pham on 17/11/21.
//

import XCTest
@testable import yonder

class yonderTests: XCTestCase {

    func testActorHealth() throws {
        let actor = ActorAbstract(maxHealth: 500)
        actor.setHealth(to: 250)
        XCTAssertEqual(actor.health, 250)
        actor.damage(for: 50)
        XCTAssertEqual(actor.health, 200)
        actor.heal(for: 500)
        XCTAssertEqual(actor.health, actor.maxHealth)
    }

}
