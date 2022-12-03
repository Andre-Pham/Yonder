//
//  PurchasableItemInfo.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class PurchasableItemInfo: Storable {
    
    public let name: String
    public let description: String
    public let type: PurchasableItem.PurchasableItemType
    
    init(name: String, description: String, type: PurchasableItem.PurchasableItemType) {
        self.name = name
        self.description = description
        self.type = type
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case type
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.type = PurchasableItem.PurchasableItemType(rawValue: dataObject.get(Field.type.rawValue))!
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.type.rawValue, value: self.type.rawValue)
    }
    
}
