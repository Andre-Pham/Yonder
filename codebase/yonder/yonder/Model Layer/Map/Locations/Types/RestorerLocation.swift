//
//  RestorerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class RestorerLocation: Location {
    
    private(set) var restorer: Restorer
    public let type: LocationType = .restorer
    
    init(restorer: Restorer) {
        self.restorer = restorer
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case restorer
    }

    required init(dataObject: DataObject) {
        self.restorer = dataObject.getObject(Field.restorer.rawValue, type: Restorer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.restorer.rawValue, value: self.restorer)
    }
    
}
