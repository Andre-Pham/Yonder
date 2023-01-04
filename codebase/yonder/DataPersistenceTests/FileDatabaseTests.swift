//
//  FileDatabaseTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 3/1/2023.
//

import XCTest
@testable import yonder

final class FileDatabaseTests: XCTestCase {
    
    let database = FileDatabase()
    
    override func setUp() async throws {
        let _ = self.database.clearDatabase()
    }

    func testWrite() throws {
        let game = TestContent.testGame()
        let record = Record(data: game)
        XCTAssert(self.database.write(record))
    }
    
    func testReadByObjectType() throws {
        let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(data: foe1)))
        XCTAssert(self.database.write(Record(data: foe2)))
        let readFoes: [Foe] = self.database.read()
        XCTAssertEqual(readFoes.count, 2)
        XCTAssert(readFoes.contains(where: { $0.name == "Foe1" }))
        XCTAssert(readFoes.contains(where: { $0.name == "Foe2" }))
    }
    
    func testReadByID() throws {
        let foe = Foe(name: "Foe", description: "Foe description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let record = Record(id: "testID", data: foe)
        XCTAssert(self.database.write(record))
        let readFoe: Foe? = self.database.read(id: "testID")
        XCTAssertNotNil(readFoe)
    }
    
    func testDeleteByObjectType() throws {
        let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
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
    }
    
    func testDeleteByID() throws {
        let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(id: "foe1", data: foe1)))
        XCTAssert(self.database.write(Record(id: "foe2", data: foe2)))
        let readFoe: Foe? = self.database.read(id: "foe2")
        XCTAssertNotNil(readFoe)
        XCTAssertEqual(readFoe?.name, "Foe2")
    }
    
    func testClearDatabase() throws {
        let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
        XCTAssert(self.database.write(Record(id: "foe1", data: foe1)))
        XCTAssert(self.database.write(Record(id: "foe2", data: foe2)))
        // 2 foes and 1 metadata object
        XCTAssertEqual(self.database.clearDatabase(), 3)
        let readFoes: [Foe] = self.database.read()
        XCTAssertEqual(readFoes.count, 0)
    }

}
