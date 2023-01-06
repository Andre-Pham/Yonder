//
//  DatabaseTargetTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 6/1/2023.
//

import XCTest
@testable import yonder

final class DatabaseTargetTests: XCTestCase {
    
    let databaseTargets: [DatabaseTarget] = [SQLiteDatabase(), FileDatabase()]
    
    override func setUp() async throws {
        self.databaseTargets.forEach({ _ = $0.clearDatabase() })
    }
    
    override func tearDown() {
        self.databaseTargets.forEach({ _ = $0.clearDatabase() })
    }

    func testWrite() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let game = TestContent.testGame()
            let record = Record(data: game)
            XCTAssert(database.write(record))
            XCTAssert(database.count() == 1)
        }
    }
    
    func testReadByObjectType() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            XCTAssert(database.write(Record(data: foe1)))
            XCTAssert(database.write(Record(data: foe2)))
            let readFoes: [Foe] = database.read()
            XCTAssertEqual(readFoes.count, 2)
            XCTAssert(readFoes.contains(where: { $0.name == "Foe1" }))
            XCTAssert(readFoes.contains(where: { $0.name == "Foe2" }))
            XCTAssert(database.count() == 2)
        }
    }
    
    func testReadByID() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let foe = Foe(name: "Foe", description: "Foe description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let record = Record(id: "testID", data: foe)
            XCTAssert(database.write(record))
            let readFoe: Foe? = database.read(id: "testID")
            XCTAssertNotNil(readFoe)
            XCTAssert(database.count() == 1)
        }
    }
    
    func testDeleteByObjectType() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let game = TestContent.testGame()
            XCTAssert(database.write(Record(data: game)))
            XCTAssert(database.write(Record(data: foe1)))
            XCTAssert(database.write(Record(data: foe2)))
            let countDeleted = database.delete(Foe.self)
            XCTAssertEqual(countDeleted, 2)
            let readFoes: [Foe] = database.read()
            XCTAssertEqual(readFoes.count, 0)
            let readGames: [Game] = database.read()
            XCTAssertEqual(readGames.count, 1)
            XCTAssert(database.count() == 1)
        }
    }
    
    func testDeleteByID() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            XCTAssert(database.write(Record(id: "foe1", data: foe1)))
            XCTAssert(database.write(Record(id: "foe2", data: foe2)))
            XCTAssert(database.delete(id: "foe1"))
            let readFoe1: Foe? = database.read(id: "foe1")
            let readFoe2: Foe? = database.read(id: "foe2")
            XCTAssertNil(readFoe1)
            XCTAssertNotNil(readFoe2)
            XCTAssert(database.count() == 1)
        }
    }
    
    func testClearDatabase() throws {
        for database in self.databaseTargets {
            print("-- DATABASE \(database.self) --")
            
            let foe1 = Foe(name: "Foe1", description: "Foe1 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            let foe2 = Foe(name: "Foe2", description: "Foe2 description.", maxHealth: 100, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
            XCTAssert(database.write(Record(id: "foe1", data: foe1)))
            XCTAssert(database.write(Record(id: "foe2", data: foe2)))
            // 2 foes and 1 metadata object
            XCTAssertEqual(database.clearDatabase(), 2)
            let readFoes: [Foe] = database.read()
            XCTAssertEqual(readFoes.count, 0)
            XCTAssert(database.count() == 0)
        }
    }

}
