//
//  FileDatabase.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2023.
//

import Foundation

class FileDatabase: DatabaseTarget {
    
    private let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let metadataFilePath = "metadata"
    
    private func createURL(path: String) -> URL {
        return URL(fileURLWithPath: path, relativeTo: self.directoryURL).appendingPathExtension("json")
    }
    
    private func readMetadataDictionary() -> MetadataDictionary {
        return self.read(id: self.metadataFilePath) ?? MetadataDictionary()
    }
    
    private func writeMetadataDictionary(_ dict: MetadataDictionary) -> Bool {
        return self.write(dict, to: self.metadataFilePath)
    }
    
    /// Write a record to the database. If the id already exists, replace it.
    /// - Parameters:
    ///   - record: The record to be written
    /// - Returns: If the write was successful
    func write<T: Storable>(_ record: Record<T>) -> Bool {
        if self.write(record.data, to: record.metadata.id) {
            let metadataDictionary = self.readMetadataDictionary()
            metadataDictionary.add(record.metadata)
            return self.writeMetadataDictionary(metadataDictionary)
        }
        return false
    }
    
    /// Write a storable object to the database.
    /// - Parameters:
    ///   - storable: The storable object to be written
    ///   - path: The path of the file to be written to
    /// - Returns: If the write was successful
    private func write<T: Storable>(_ storable: T, to path: String) -> Bool {
        let dataObject = storable.toDataObject()
        let url = self.createURL(path: path)
        do {
            let data = dataObject.rawData
            try data.write(to: url)
            return true
        } catch {
            return false
        }
    }
    
    /// Retrieve all storable objects of a specified type.
    /// - Returns: All saved objects of the specified type
    func read<T: Storable>() -> [T] {
        var result = [T]()
        let objectName = String(describing: T.self)
        let ids = self.readMetadataDictionary().getFilteredIDs({ $0.objectName == objectName })
        for url in ids.map({ self.createURL(path: $0) }) {
            if let data = try? Data(contentsOf: url) {
                let dataObject = DataObject(data: data)
                result.append(dataObject.restore(T.self))
            }
        }
        return result
    }
    
    /// Retrieve the storable object with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record
    /// - Returns: The storable object with the matching id
    func read<T: Storable>(id: String) -> T? {
        if let data = try? Data(contentsOf: self.createURL(path: id)) {
            let dataObject = DataObject(data: data)
            return dataObject.restore(T.self)
        }
        return nil
    }
    
    /// Delete all instances of an object
    /// - Parameters:
    ///   - allOf: The type to delete
    /// - Returns: The number of records deleted
    func delete<T: Storable>(_ allOf: T.Type) -> Int {
        var count = 0
        let objectName = String(describing: T.self)
        let ids = self.readMetadataDictionary().getFilteredIDs({ $0.objectName == objectName })
        for url in ids.map({ self.createURL(path: $0) }) {
            do {
                try FileManager.default.removeItem(at: url)
                count += 1
            } catch {
                assertionFailure("File failed to be deleted")
            }
        }
        let metadataDictionary = self.readMetadataDictionary()
        let filterCount = metadataDictionary.filterOut({ $0.objectName == objectName })
        assert(filterCount == count, "The number of records deleted between files and the metadata dictionary is inconsistent")
        guard self.writeMetadataDictionary(metadataDictionary) else {
            assertionFailure("Metadata dictionary failed to be updated")
            return 0
        }
        return count
    }
    
    /// Delete the record with the matching id.
    /// - Parameters:
    ///   - id: The id of the stored record to delete
    /// - Returns: If any record was successfully deleted
    func delete(id: String) -> Bool {
        let url = self.createURL(path: id)
        do {
            try FileManager.default.removeItem(at: url)
            let metadataDictionary = self.readMetadataDictionary()
            let removedCount = metadataDictionary.removeIDs([id])
            return removedCount == 1 && self.writeMetadataDictionary(metadataDictionary)
        } catch {
            assertionFailure("File failed to be deleted")
            return false
        }
    }
    
    /// Clear the entire database.
    /// - Returns: The number of records deleted (NOT including the MetadataDictionary object)
    func clearDatabase() -> Int {
        var count = 0
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: self.directoryURL,
                includingPropertiesForKeys: nil
            )
            for url in directoryContents {
                do {
                    try FileManager.default.removeItem(at: url)
                    count += 1
                } catch {
                    assertionFailure("File failed to be deleted")
                }
            }
            if directoryContents.count > 0 {
                count -= 1 // Accounts for the MetadataDictionary which doesn't count as a record
            }
        } catch {
            assertionFailure("File manager failed to read directory")
        }
        return count
    }
    
    /// Count the number of records saved.
    /// - Returns: The number of records
    func count() -> Int {
        var count = 0
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: self.directoryURL,
                includingPropertiesForKeys: nil
            )
            count += directoryContents.count
            if directoryContents.count > 0 {
                count -= 1 // Accounts for the MetadataDictionary which doesn't count as a record
            }
        } catch {
            assertionFailure("File manager failed to read directory")
        }
        return count
    }
    
}
