//
//  HexagonCoordinate.swift
//  yonder
//
//  Created by Andre Pham on 16/12/21.
//

import Foundation

class HexagonCoordinate: Identifiable, Storable {
    
    public let x: Int
    public let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case x
        case y
    }

    required init(dataObject: DataObject) {
        self.x = dataObject.get(Field.x.rawValue)
        self.y = dataObject.get(Field.y.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.x.rawValue, value: self.x)
            .add(key: Field.y.rawValue, value: self.y)
    }
    
}
