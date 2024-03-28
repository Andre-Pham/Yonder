//
//  DatabaseTargetPerformanceTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 6/1/2023.
//

import XCTest
@testable import yonder
import SwiftSerialization

final class DatabaseTargetPerformanceTests: XCTestCase {

    let database = SerializationDatabase()
    let game = TestContent.testGame()
    
    override func setUp() async throws {
        self.database.clearDatabase()
    }
    
    override func tearDown() {
        self.database.clearDatabase()
    }

    func testWrite() throws {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            self.startMeasuring()
            let success = self.database.write(Record(data: self.game))
            self.stopMeasuring()
            XCTAssertTrue(success)
       }
    }
    
    func testRead() throws {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            XCTAssert(self.database.write(Record(id: "testgame", data: self.game)))
            self.startMeasuring()
            let readGame: Game? = self.database.read(id: "testgame")
            self.stopMeasuring()
            XCTAssertNotNil(readGame)
       }
    }
    
    func testDeleteByID() throws {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            XCTAssert(self.database.write(Record(id: "testgame", data: self.game)))
            self.startMeasuring()
            let success = self.database.delete(id: "testgame")
            self.stopMeasuring()
            XCTAssertTrue(success)
       }
    }
    
    func testDeleteByType() throws {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            XCTAssert(self.database.write(Record(data: self.game)))
            self.startMeasuring()
            let count = self.database.delete(Game.self)
            self.stopMeasuring()
            XCTAssertEqual(count, 1)
       }
    }

}
