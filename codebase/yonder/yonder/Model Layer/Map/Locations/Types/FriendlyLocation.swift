//
//  FriendlyLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class FriendlyLocation: Location {
    
    private(set) var friendly: Friendly
    public let type: LocationType = .friendly
    
    init(friendly: Friendly) {
        self.friendly = friendly
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case friendly
    }

    required init(dataObject: DataObject) {
        self.friendly = dataObject.getObject(Field.friendly.rawValue, type: Friendly.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.friendly.rawValue, value: self.friendly)
    }
    
}
