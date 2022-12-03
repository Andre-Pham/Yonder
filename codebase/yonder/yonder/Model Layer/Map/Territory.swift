//
//  Territory.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class Territory: Storable {
    
    private(set) var segment: Segment
    private(set) var tavernArea: TavernArea
    public let rootLocations: [Location]
    public let tipLocations: [Location]
    
    init(segment: Segment, followingTavernArea: TavernArea) {
        self.segment = segment
        self.tavernArea = followingTavernArea
        
        for area in segment.allAreas {
            area.tipLocation.addNextLocations(self.tavernArea.rootLocations)
        }
        
        self.rootLocations = self.segment.allAreas.map { $0.rootLocation }
        self.tipLocations = self.tavernArea.tipLocations
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case segment
        case tavernArea
    }

    required init(dataObject: DataObject) {
        self.segment = dataObject.getObject(Field.segment.rawValue, type: Segment.self)
        self.tavernArea = dataObject.getObject(Field.tavernArea.rawValue, type: TavernArea.self)
        
        self.rootLocations = self.segment.allAreas.map { $0.rootLocation }
        self.tipLocations = self.tavernArea.tipLocations
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.segment.rawValue, value: self.segment)
            .add(key: Field.tavernArea.rawValue, value: self.tavernArea)
    }
    
}
