//
//  StatusEffectTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class StatusEffectTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    
    // MARK: - Basic
    
    func testStatusEffectExpiration() throws {
        self.player.addStatusEffect(BurnStatusEffect(damage: 10, duration: 1))
        XCTAssertEqual(self.player.statusEffects.count, 1)
        self.player.onTurnCompletion()
        XCTAssertTrue(self.player.statusEffects.isEmpty)
    }
    
    func testBurnStatusEffect() throws {
        self.player.addStatusEffect(BurnStatusEffect(damage: 10, duration: 2))
        self.player.onTurnCompletion()
        XCTAssertEqual(self.player.health, 490)
    }

}
