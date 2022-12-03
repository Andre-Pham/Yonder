//
//  ChallengeHostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ChallengeHostileLocation: Location, FoeLocation {
    
    private(set) var foe: Foe
    public let type: LocationType = .challengeHostile
    
    init(foe: Foe) {
        self.foe = foe
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case foe
    }

    required init(dataObject: DataObject) {
        self.foe = dataObject.getObject(Field.foe.rawValue, type: Foe.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.foe.rawValue, value: self.foe)
    }
    
}
