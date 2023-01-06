//
//  DatabaseTargetPerformanceTests.swift
//  DataPersistenceTests
//
//  Created by Andre Pham on 6/1/2023.
//

import XCTest
@testable import yonder

final class DatabaseTargetPerformanceTests: XCTestCase {

    let databaseTargets: [DatabaseTarget] = [SQLiteDatabase(), FileDatabase()]
    let largeRecords: [Record] = Array(count: 10, populateWith: Record(data: TestContent.testGame()))
    let smallRecords: [Record] = Array(count: 100, populateWith: Record(data: TestContent.testHeadArmor()))
    
    override func setUp() async throws {
        self.databaseTargets.forEach({ _ = $0.clearDatabase() })
    }
    
    override func tearDown() {
        self.databaseTargets.forEach({ _ = $0.clearDatabase() })
    }

    func testWrite() throws {
        var results = [String: Double]()
        for database in self.databaseTargets {
            let timeTaken = TestPerformance.executionDuration() {
                self.largeRecords.forEach({ _ = database.write($0) })
                self.smallRecords.forEach({ _ = database.write($0) })
            }
            results[String(describing: database.self)] = timeTaken
        }
        print("============================== WRITE ==============================")
        self.printResults(results)
        print("============================== END WRITE ==========================")
    }
    
    func testRead() throws {
        var results = [String: Double]()
        for database in self.databaseTargets {
            self.largeRecords.forEach({ _ = database.write($0) })
            self.smallRecords.forEach({ _ = database.write($0) })
            let timeTaken = TestPerformance.executionDuration() {
                let _: [Game] = database.read()
                let _: [Armor] = database.read()
                for record in self.largeRecords {
                    let id = record.metadata.id
                    let _: Game? = database.read(id: id)
                }
                for record in self.smallRecords {
                    let id = record.metadata.id
                    let _: Armor? = database.read(id: id)
                }
            }
            results[String(describing: database.self)] = timeTaken
        }
        print("============================== READ ===============================")
        self.printResults(results)
        print("============================== END READ ===========================")
    }
    
    func testDelete() throws {
        var results = [String: Double]()
        for database in self.databaseTargets {
            self.largeRecords.forEach({ _ = database.write($0) })
            self.smallRecords.forEach({ _ = database.write($0) })
            let timeTaken1 = TestPerformance.executionDuration() {
                let _ = database.delete(Game.self)
                let _ = database.delete(Armor.self)
            }
            self.largeRecords.forEach({ _ = database.write($0) })
            self.smallRecords.forEach({ _ = database.write($0) })
            let timeTaken2 = TestPerformance.executionDuration() {
                for record in self.largeRecords {
                    let id = record.metadata.id
                    let _ = database.delete(id: id)
                }
                for record in self.smallRecords {
                    let id = record.metadata.id
                    let _ = database.delete(id: id)
                }
            }
            results[String(describing: database.self)] = timeTaken1 + timeTaken2
        }
        print("============================== DELETE =============================")
        self.printResults(results)
        print("============================== END DELETE =========================")
    }
    
    private func printResults(_ results: [String: Double]) {
        var resultsArray: [(String, Double)] = results.map({ key, value in
            (key, value)
        })
        resultsArray.sort(by: { $0.1 < $1.1 })
        for result in resultsArray {
            print("> \(result.0): \(result.1.rounded(decimalPlaces: 2)) seconds")
        }
        if resultsArray.count > 1 {
            let result1 = resultsArray[0]
            let result2 = resultsArray[1]
            let percentage: Double = ((1 - result1.1/result2.1)*100.0).rounded(decimalPlaces: 1)
            print("\(result1.0) was faster than \(result2.0) by \(percentage)%")
        }
    }

}
