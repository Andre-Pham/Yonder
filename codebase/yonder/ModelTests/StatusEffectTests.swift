//
//  StatusEffectTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class StatusEffectTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    
    // MARK: - Basic
    
    func testStatusEffectExpiration() throws {
        self.player.addStatusEffect(BurnStatusEffect(damage: 10, duration: 1))
        XCTAssertEqual(self.player.statusEffects.count, 1)
        self.testSession.completeTurn(player: self.player)
        XCTAssertTrue(self.player.statusEffects.isEmpty)
    }
    
    func testBurnStatusEffect() throws {
        self.player.addStatusEffect(BurnStatusEffect(damage: 10, duration: 2))
        self.testSession.completeTurn(player: self.player)
        XCTAssertEqual(self.player.health, 490)
    }

}
