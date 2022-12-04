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
        Session.instance.startNewGame()
        let game = Session.instance.activeGame!
        Session.instance.saveGame()
        Session.instance.loadGame()
    }

}
