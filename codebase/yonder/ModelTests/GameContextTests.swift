//
//  GameContextTests.swift
//  ModelTests
//
//  Created by Andre Pham on 3/1/2023.
//

import XCTest
@testable import yonder

final class GameContextTests: XCTestCase {
    
    let testSession = TestSession.instance // Begin test session

    func testPlayerStage() throws {
        let player = self.testSession.game.player
        XCTAssertEqual(self.testSession.game.gameContext.playerStageManager.stage, 0)
        for _ in 0...50 {
            let nextLocations = Array(player.location.nextLocations)
            guard let nextLocation = nextLocations.first(where: { !$0.hasBeenVisited }) else {
                XCTFail()
                break
            }
            player.travel(to: nextLocation)
        }
        XCTAssertNotEqual(self.testSession.game.gameContext.playerStageManager.stage, 0)
    }
    
    func testTurnManager() throws {
        // To test the turn manager, we check if the foe attacks back when the player attacks
        let player = Player(maxHealth: 100, location: NoLocation())
        let foe = Foe(contentID: nil, maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        player.useWeaponWhere(opposition: foe, weapon: BaseAttack(damage: 0))
        XCTAssert(player.isDead)
    }
    
    func testPlayerDeath() throws {
        // To test stable states, we see if the player death publisher is triggered
        // (This only triggers when a stable state is reached)
        
        class TestSubscriber: AfterPlayerDeathSubscriber {
            var eventTriggered = false
            
            init() {
                AfterPlayerDeathPublisher.subscribe(self)
            }
            
            func afterPlayerDeath(player: Player) {
                self.eventTriggered = true
            }
        }
        
        let testSubscriber = TestSubscriber()
        XCTAssertFalse(testSubscriber.eventTriggered)
        let player = Player(maxHealth: 100, location: NoLocation())
        player.damage(for: player.maxHealth)
        self.testSession.completeTurn(player: player)
        XCTAssertTrue(testSubscriber.eventTriggered)
    }

}
