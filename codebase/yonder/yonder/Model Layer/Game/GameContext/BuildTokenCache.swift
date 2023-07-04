//
//  BuildTokenCache.swift
//  yonder
//
//  Created by Andre Pham on 4/7/2023.
//

import Foundation

class BuildTokenCache: Storable {
    
    public let regionKey: String
    public let serialisedTokens: [String]
    
    init(regionKey: String, serialisedTokens: [String]) {
        self.regionKey = regionKey
        self.serialisedTokens = serialisedTokens
    }
    
    private enum Field: String {
        case regionKey
        case serialisedTokens
    }
    
    required init(dataObject: DataObject) {
        self.regionKey = dataObject.get(Field.regionKey.rawValue)
        self.serialisedTokens = dataObject.get(Field.serialisedTokens.rawValue)
    }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.regionKey.rawValue, value: self.regionKey)
            .add(key: Field.serialisedTokens.rawValue, value: self.serialisedTokens)
    }
    
}
