//
//  EnhancerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class EnhancerLocation: Location {
    
    private(set) var enhancer: Enhancer
    public let type: LocationType = .enhancer
    
    init(enhancer: Enhancer) {
        self.enhancer = enhancer
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case enhancer
    }

    required init(dataObject: DataObject) {
        self.enhancer = dataObject.getObject(Field.enhancer.rawValue, type: Enhancer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.enhancer.rawValue, value: self.enhancer)
    }
    
}
