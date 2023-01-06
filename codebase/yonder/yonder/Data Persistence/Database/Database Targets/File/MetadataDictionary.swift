//
//  MetadataDictionary.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2023.
//

import Foundation

class MetadataDictionary: Storable {
    
    private(set) var metadataDictionary = [String: Metadata]()
    
    init() { }
    
    func add(_ metadata: Metadata) {
        self.metadataDictionary[metadata.id] = metadata
    }
    
    func getFilteredIDs(_ condition: (_ metadata: Metadata) -> Bool) -> [String] {
        var result = [String]()
        for metadata in self.metadataDictionary.values {
            if condition(metadata) {
                result.append(metadata.id)
            }
        }
        return result
    }
    
    func removeIDs(_ ids: [String]) -> Int {
        var count = 0
        for id in ids {
            if self.metadataDictionary.removeValue(forKey: id) != nil {
                count += 1
            }
        }
        return count
    }
    
    func filterOut(_ condition: (_ value: Metadata) -> Bool) -> Int {
        var count = 0
        for (id, metadata) in self.metadataDictionary {
            if condition(metadata) {
                self.metadataDictionary.removeValue(forKey: id)
                count += 1
            }
        }
        return count
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case allMetadata
    }

    required init(dataObject: DataObject) {
        dataObject.getObjectArray(Field.allMetadata.rawValue, type: Metadata.self).forEach {
            self.add($0)
        }
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.allMetadata.rawValue, value: Array(self.metadataDictionary.values))
    }
    
}
