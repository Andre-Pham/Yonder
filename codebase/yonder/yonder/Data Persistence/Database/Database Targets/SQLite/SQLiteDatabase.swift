//
//  SQLiteDatabase.swift
//  yonder
//
//  Created by Andre Pham on 5/1/2023.
//

import Foundation
import SQLite3

class SQLiteDatabase: DatabaseTarget {
    
    /// The directory the sqlite file is saved to
    private let url: URL
    /// The database instance
    private var database: OpaquePointer? = nil
    /// The date formatter used for adding and retrieving dates
    private var dateFormatter: DateFormatter {
        let result = DateFormatter()
        result.locale = Locale(identifier: "en_US_POSIX")
        result.timeZone = TimeZone(secondsFromGMT: 0)
        result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return result
    }
    
    init() {
        self.url = FileManager.default.urls(for: .libraryDirectory, in: .allDomainsMask)[0]
            .appendingPathComponent("records.sqlite")
        guard sqlite3_open(self.url.path, &self.database) == SQLITE_OK else {
            assertionFailure("SQLite database could not be opened")
            return
        }
        self.setupTable()
    }
    
    private func setupTable() {
        let statementString = """
        CREATE TABLE IF NOT EXISTS record(
            id TEXT PRIMARY KEY,
            objectName TEXT,
            createdAt TEXT,
            data TEXT
        );
        """
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            let outcome = sqlite3_step(statement) == SQLITE_DONE
            assert(outcome, "SQLite table could not be created")
            sqlite3_finalize(statement)
        }
    }
    
    /// Write a record to the database. If the id already exists, replace it.
    /// - Parameters:
    ///   - record: The record to be written
    /// - Returns: If the write was successful
    func write<T: Storable>(_ record: Record<T>) -> Bool {
        let statementString = "REPLACE INTO record (id, objectName, createdAt, data) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (record.metadata.id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (record.metadata.objectName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (self.dateFormatter.string(from: record.metadata.createdAt) as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (String(decoding: record.data.toDataObject().rawData, as: UTF8.self) as NSString).utf8String, -1, nil)
            let outcome = sqlite3_step(statement) == SQLITE_DONE
            sqlite3_finalize(statement)
            return outcome
        }
        return false
    }
    
    /// Retrieve all storable objects of a specified type.
    /// - Returns: All saved objects of the specified type
    func read<T: Storable>() -> [T] {
        let objectName = String(describing: T.self)
        let statementString = "SELECT * FROM record WHERE objectName = ?;"
        var statement: OpaquePointer? = nil
        var result = [T]()
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (objectName as NSString).utf8String, -1, nil)
            while sqlite3_step(statement) == SQLITE_ROW {
                // These may come in handy later:
                //let id = String(describing: String(cString: sqlite3_column_text(statement, 0)))
                //let objectName = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                //let createdAt = self.dateFormatter.date(from: String(describing: String(cString: sqlite3_column_text(statement, 2)))) ?? Date()
                let dataString = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                guard let data = dataString.data(using: .utf8) else {
                    continue
                }
                let dataObject = DataObject(data: data)
                result.append(dataObject.restore(T.self))
            }
        }
        sqlite3_finalize(statement)
        return result
    }
    
    /// Retrieve the storable object with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record
    /// - Returns: The storable object with the matching id
    func read<T: Storable>(id: String) -> T? {
        let statementString = "SELECT * FROM record WHERE id = ?;"
        var statement: OpaquePointer? = nil
        var result: T? = nil
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (id as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_ROW {
                let dataString = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                if let data = dataString.data(using: .utf8) {
                    let dataObject = DataObject(data: data)
                    result = dataObject.restore(T.self)
                }
            }
        }
        sqlite3_finalize(statement)
        return result
    }
    
    /// Delete all instances of an object
    /// - Parameters:
    ///   - allOf: The type to delete
    /// - Returns: The number of records deleted
    func delete<T: Storable>(_ allOf: T.Type) -> Int {
        var count = 0
        let objectName = String(describing: T.self)
        let statementString = "DELETE FROM record WHERE objectName = ?;"
        var statement: OpaquePointer? = nil
        let countBeforeDelete = self.count()
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (objectName as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                count = countBeforeDelete - self.count()
            }
        }
        sqlite3_finalize(statement)
        return count
    }
    
    /// Delete the record with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record to delete
    /// - Returns: If any record was successfully deleted
    func delete(id: String) -> Bool {
        var successful = false
        let statementString = "DELETE FROM record WHERE id = ?;"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (id as NSString).utf8String, -1, nil)
            successful = sqlite3_step(statement) == SQLITE_DONE
        }
        sqlite3_finalize(statement)
        return successful
    }
    
    /// Clear the entire database.
    /// - Returns: The number of records deleted
    func clearDatabase() -> Int {
        var countDeleted = 0
        let statementString = "DELETE FROM record;"
        var statement: OpaquePointer? = nil
        let count = self.count()
        if sqlite3_prepare_v2(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                countDeleted = count
            }
        }
        sqlite3_finalize(statement)
        return countDeleted
    }
    
    /// Count the number of records saved.
    /// - Returns: The number of records
    func count() -> Int {
        var count = 0
        let statementString = "SELECT COUNT(*) FROM record;"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare(self.database, statementString, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                count = Int(sqlite3_column_int(statement, 0))
            } else {
                assertionFailure("Counting records statement could not be executed")
            }
        }
        sqlite3_finalize(statement)
        return count
    }
    
}
