//
//  Area.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation
import SwiftUI

class Area: Named, Described, Storable {
    
    public let name: String
    public let description: String
    public let imageResource: ImageResource
    public let rootLocation: Location
    public let tipLocation: Location
    private(set) var leftBridgeLocations = [Location]()
    private(set) var rightBridgeLocations = [Location]()
    public let arrangement: AreaArrangements
    public let locations: [Location]
    public let id = UUID()
    
    // locations are received from LocationsGenerator
    init(
        arrangement: AreaArrangements,
        locations: [Location],
        name: String = "placeholderName",
        description: String = "placeholderDescription",
        imageResource: ImageResource = YonderImages.placeholderImage
    ) {
        assert(locations.count == arrangement.locationCount, "Number of locations provided to generate Area doesn't match expected number for the arrangement")
        self.arrangement = arrangement
        self.locations = locations
        self.rootLocation = locations.first!
        self.tipLocation = locations.last!
        self.name = name
        self.description = description
        self.imageResource = imageResource
        
        self.locations.forEach { $0.setAreaContext(self) }
        self.generateAreaArrangement()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case imageName
        case arrangement
        case locations
        case leftBridgeLocationIDs
        case rightBridgeLocationIDs
        case rootLocationID
        case tipLocationID
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.imageResource = ImageResource(dataObject.get(Field.imageName.rawValue))
        self.arrangement = AreaArrangements(rawValue: dataObject.get(Field.arrangement.rawValue))!
        self.locations = dataObject.getObjectArray(Field.locations.rawValue, type: LocationAbstract.self) as! [any Location]
        
        // Below - we could repeat the algorithms used to generate the relevant fields
        // These are safer because they're algorithm independent, so they'll adapt to any future changes
        
        let rootLocationID = UUID(uuidString: dataObject.get(Field.rootLocationID.rawValue))
        self.rootLocation = self.locations.first(where: { $0.id == rootLocationID })!
        let tipLocationID = UUID(uuidString: dataObject.get(Field.tipLocationID.rawValue))
        self.tipLocation = self.locations.first(where: { $0.id == tipLocationID })!
        
        let leftBridgeStrings: [String] = dataObject.get(Field.leftBridgeLocationIDs.rawValue)
        let leftBridgeIDs = leftBridgeStrings.map({ UUID(uuidString: $0)! })
        let rightBridgeStrings: [String] = dataObject.get(Field.rightBridgeLocationIDs.rawValue)
        let rightBridgeIDs = rightBridgeStrings.map({ UUID(uuidString: $0)! })
        for location in self.locations {
            if leftBridgeIDs.contains(where: { $0 == location.id }) {
                self.leftBridgeLocations.append(location)
            } else if rightBridgeIDs.contains(where: { $0 == location.id }) {
                self.rightBridgeLocations.append(location)
            }
        }
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.imageName.rawValue, value: self.imageResource.name)
            .add(key: Field.arrangement.rawValue, value: self.arrangement.rawValue)
            .add(key: Field.locations.rawValue, value: self.locations as [LocationAbstract])
            .add(key: Field.rootLocationID.rawValue, value: self.rootLocation.id.uuidString)
            .add(key: Field.tipLocationID.rawValue, value: self.tipLocation.id.uuidString)
            .add(key: Field.leftBridgeLocationIDs.rawValue, value: self.leftBridgeLocations.map({ $0.id.uuidString }))
            .add(key: Field.rightBridgeLocationIDs.rawValue, value: self.rightBridgeLocations.map({ $0.id.uuidString }))
    }

    // MARK: - Functions
    
    func addNextLocations(from location: Location, to nextLocations: [Location]) {
        location.addNextLocations(nextLocations)
        for location in nextLocations {
            if location.bridgeAccessibility == .leftBridge {
                self.leftBridgeLocations.append(location)
            }
            else if location.bridgeAccessibility == .rightBridge {
                self.rightBridgeLocations.append(location)
            }
        }
    }
    
    func addNextLocations(from locationIndex: Int, to nextLocationIndices: Int...) {
        let location = self.locations[locationIndex]
        let nextLocations = nextLocationIndices.map { self.locations[$0] }
        self.addNextLocations(from: location, to: nextLocations)
    }
    
    func filterLeftBridgeLocationsWithY(of y: Int) {
        self.leftBridgeLocations = self.leftBridgeLocations.filter { $0.hexagonCoordinate!.y != y }
    }
    
    func filterRightBridgeLocationsWithY(of y: Int) {
        self.rightBridgeLocations = self.rightBridgeLocations.filter { $0.hexagonCoordinate!.y != y }
    }
    
}
