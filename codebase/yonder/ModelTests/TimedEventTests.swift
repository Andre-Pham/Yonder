//
//  TimedEventTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class TimedEventTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    
    // MARK: - Basic
    
    func testTimedEventExpiration() throws {
        self.player.addTimedEvent(MaxHealthRestorationTimedEvent(timeToTrigger: 1))
        XCTAssertEqual(self.player.timedEvents.count, 1)
        self.testSession.completeTurn(player: self.player)
        XCTAssertTrue(self.player.timedEvents.isEmpty)
    }
    
    func testMaxHealthRestorationTimedEvent() throws {
        self.player.damage(for: 300)
        self.player.addTimedEvent(MaxHealthRestorationTimedEvent(timeToTrigger: 2))
        self.testSession.completeTurn(player: self.player)
        XCTAssertEqual(self.player.health, 200)
        self.testSession.completeTurn(player: self.player)
        XCTAssertEqual(self.player.health, self.player.maxHealth)
    }

}
