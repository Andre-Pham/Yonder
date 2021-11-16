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
    
    func testAttack() throws {
        GAME.foe.attackPlayer()
        XCTAssertEqual(GAME.player.health, GAME.player.maxHealth-GAME.foe.attackDamage)
    }
    
    func testDeath() throws {
        let player = Player(maxHealth: 200)
        player.damage(for: 150)
        XCTAssertTrue(!player.isDead)
        player.damage(for: 150)
        XCTAssertTrue(player.isDead)
    }
    
    func testStatusEffects() throws {
        let player = Player(maxHealth: 200)
        player.addStatusEffect(BurnStatusEffect(damage: 5))
        player.triggerStatusEffects()
        XCTAssertTrue(player.health == 195)
    }

}
