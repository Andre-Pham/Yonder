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

}
