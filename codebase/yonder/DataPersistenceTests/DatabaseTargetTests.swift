//
//  DatabaseTargetTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 6/1/2023.
//

import XCTest
@testable import yonder
import SwiftSerialization

final class DatabaseTargetTests: XCTestCase {
    
    let database = SerializationDatabase()
    
    override func setUp() async throws {
        self.database.clearDatabase()
    }
    
    override func tearDown() {
        self.database.clearDatabase()
    }

    func testWrite() throws {
        let game = TestContent.testGame()
        let record = Record(data: game)
        XCTAssert(self.database.write(record))
        XCTAssert(self.database.count() == 1)
    }
    
    func testReadByObjectType() throws {
        let foe1 = Foe(contentID: nil, name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(contentID: nil, name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(data: foe1)))
        XCTAssert(self.database.write(Record(data: foe2)))
        let readFoes: [Foe] = self.database.read()
        XCTAssertEqual(readFoes.count, 2)
        XCTAssert(readFoes.contains(where: { $0.name == "Foe1" }))
        XCTAssert(readFoes.contains(where: { $0.name == "Foe2" }))
        XCTAssert(self.database.count() == 2)
    }
    
    func testReadByID() throws {
        let foe = Foe(contentID: nil, name: "Foe", description: "Foe description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let record = Record(id: "testID", data: foe)
        XCTAssert(self.database.write(record))
        let readFoe: Foe? = database.read(id: "testID")
        XCTAssertNotNil(readFoe)
        XCTAssert(self.database.count() == 1)
    }
    
    func testDeleteByObjectType() throws {
        let foe1 = Foe(contentID: nil, name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(contentID: nil, name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let game = TestContent.testGame()
        XCTAssert(self.database.write(Record(data: game)))
        XCTAssert(self.database.write(Record(data: foe1)))
        XCTAssert(self.database.write(Record(data: foe2)))
        let countDeleted = self.database.delete(Foe.self)
        XCTAssertEqual(countDeleted, 2)
        let readFoes: [Foe] = self.database.read()
        XCTAssertEqual(readFoes.count, 0)
        let readGames: [Game] = self.database.read()
        XCTAssertEqual(readGames.count, 1)
        XCTAssert(self.database.count() == 1)
    }
    
    func testDeleteByID() throws {
        let foe1 = Foe(contentID: nil, name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(contentID: nil, name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(id: "foe1", data: foe1)))
        XCTAssert(self.database.write(Record(id: "foe2", data: foe2)))
        XCTAssert(self.database.delete(id: "foe1"))
        let readFoe1: Foe? = database.read(id: "foe1")
        let readFoe2: Foe? = database.read(id: "foe2")
        XCTAssertNil(readFoe1)
        XCTAssertNotNil(readFoe2)
        XCTAssert(self.database.count() == 1)
    }
    
    func testClearDatabase() throws {
        let foe1 = Foe(contentID: nil, name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(contentID: nil, name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(id: "foe1", data: foe1)))
        XCTAssert(self.database.write(Record(id: "foe2", data: foe2)))
        // 2 foes and 1 metadata object
        XCTAssertEqual(self.database.clearDatabase(), 2)
        let readFoes: [Foe] = database.read()
        XCTAssertEqual(readFoes.count, 0)
        XCTAssert(self.database.count() == 0)
    }
    
    func testReplace() throws {
        let foe1 = Foe(contentID: nil, name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(contentID: nil, name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(id: "foe", data: foe1)))
        XCTAssert(self.database.write(Record(id: "foe", data: foe2)))
        let readFoe: Foe? = self.database.read(id: "foe")
        XCTAssertEqual(readFoe?.name, foe2.name)
        XCTAssert(self.database.count() == 1)
    }

}
