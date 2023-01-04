//
//  Metadata.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2023.
//

import Foundation

class Metadata: Storable {
    
    public let id: String
    public let objectName: String
    public let createdAt: Date
    
    init(objectName: String, id: String) {
        self.objectName = objectName
        self.id = id
        self.createdAt = Date.now
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case id
        case objectName
        case createdAt
    }

    required init(dataObject: DataObject) {
        self.id = dataObject.get(Field.id.rawValue)
        self.objectName = dataObject.get(Field.objectName.rawValue)
        self.createdAt = dataObject.get(Field.createdAt.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.id.rawValue, value: self.id)
            .add(key: Field.objectName.rawValue, value: self.objectName)
            .add(key: Field.createdAt.rawValue, value: self.createdAt)
    }
    
}
