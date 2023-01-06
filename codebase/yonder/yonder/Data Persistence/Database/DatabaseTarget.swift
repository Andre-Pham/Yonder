//
//  DatabaseTarget.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2023.
//

import Foundation

protocol DatabaseTarget {
    
    /// Write a record to the database. If the id already exists, replace it.
    /// - Parameters:
    ///   - record: The record to be written
    /// - Returns: If the write was successful
    func write<T: Storable>(_ record: Record<T>) -> Bool
    
    /// Retrieve all storable objects of a specified type.
    /// - Returns: All saved objects of the specified type
    func read<T: Storable>() -> [T]
    
    /// Retrieve the storable object with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record
    /// - Returns: The storable object with the matching id
    func read<T: Storable>(id: String) -> T?
    
    /// Delete all instances of an object
    /// - Parameters:
    ///   - allOf: The type to delete
    /// - Returns: The number of records deleted
    func delete<T: Storable>(_ allOf: T.Type) -> Int
    
    /// Delete the record with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record to delete
    /// - Returns: If any record was successfully deleted
    func delete(id: String) -> Bool
    
    /// Clear the entire database.
    /// - Returns: The number of records deleted
    func clearDatabase() -> Int
    
    /// Count the number of records saved.
    /// - Returns: The number of records
    func count() -> Int
    
}
