//
//  GameTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 4/12/2022.
//

import XCTest
@testable import yonder

final class GameTests: XCTestCase {

    func testGameSerialisation() throws {
        Session.instance.startNewGame(playerClass: .none)
        XCTAssert(Session.instance.activeGame != nil)
        XCTAssert(Session.instance.saveGame())
        XCTAssert(Session.instance.loadGame())
    }
    
    func testGameFunctionality() throws {
        Session.instance.startNewGame(playerClass: .none)
        XCTAssert(Session.instance.saveGame())
        XCTAssert(Session.instance.loadGame())
        let player = Session.instance.activeGame!.player
        for _ in 0..<50 {
            player.travel(to: player.location.nextLocations.sorted(by: { $0.hexagonCoordinate!.y > $1.hexagonCoordinate!.y }).first!)
            if let foe = (player.location as? FoeLocation)?.foe {
                player.useWeaponWhere(opposition: foe, weapon: BaseAttack(damage: 50))
            }
        }
    }

}
