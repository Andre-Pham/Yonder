//
//  BossArea.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossArea: Storable {
    
    public let bossLocation: BossLocation
    public let restorerLocation: RestorerLocation
    public var locations: [Location] {
        return [self.bossLocation, self.restorerLocation]
    }
    public var rootLocations: [Location] {
        return [self.bossLocation]
    }
    public var tipLocations: [Location] {
        return [self.restorerLocation]
    }
    
    init(bossLocation: BossLocation, restorerLocation: RestorerLocation) {
        self.bossLocation = bossLocation
        self.restorerLocation = restorerLocation
        
        self.bossLocation.addNextLocations([restorerLocation])
        self.bossLocation.setHexagonCoordinate(5, 33)
        self.restorerLocation.setHexagonCoordinate(5, 35)
        
        for location in self.locations {
            let referenceLocation = self.rootLocations.first!
            let context = referenceLocation.context
            location.setContext(key: context.key, name: context.name, description: context.description, imageResource: context.imageResource)
        }
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case bossLocation
        case restorerLocation
    }

    required init(dataObject: DataObject) {
        self.bossLocation = dataObject.getObject(Field.bossLocation.rawValue, type: BossLocation.self)
        self.restorerLocation = dataObject.getObject(Field.restorerLocation.rawValue, type: RestorerLocation.self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.bossLocation.rawValue, value: self.bossLocation)
            .add(key: Field.restorerLocation.rawValue, value: self.restorerLocation)
    }
    
}
