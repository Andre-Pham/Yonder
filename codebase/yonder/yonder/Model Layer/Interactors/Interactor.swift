//
//  Interactor.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class InteractorAbstract: Named, Described, Storable {
    
    /// The ID that indicates what content (sprite sheet and metadata) to use to represent this foe, e.g. E0001
    private(set) var contentID: String?
    private(set) var name: String
    private(set) var description: String
    
    init(contentID: String?, name: String, description: String) {
        self.contentID = contentID
        self.name = name
        self.description = description
    }
    
    func overrideProfileContent(contentID: String?, name: String, description: String) {
        self.contentID = contentID
        self.name = name
        self.description = description
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case contentID
        case name
        case description
    }

    required init(dataObject: DataObject) {
        self.contentID = dataObject.get(Field.contentID.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.contentID.rawValue, value: self.contentID)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
    }
    
}
