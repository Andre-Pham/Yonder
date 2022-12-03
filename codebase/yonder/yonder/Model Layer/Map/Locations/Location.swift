//
//  Location.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias Location = LocationAbstract & LocationTyped

protocol LocationTyped {
    
    var type: LocationType { get }
    
}

class LocationAbstract: Storable {
    
    private var nextLocationIDs = [UUID]()
    var nextLocations: [Location] {
        LocationCache.getLocations(ids: self.nextLocationIDs)
    }
    private(set) var bridgeLocation: BridgeLocation?
    private(set) var bridgeAccessibility: LocationBridgeAccessibility
    private(set) var hexagonCoordinate: HexagonCoordinate?
    private(set) var context = LocationContext()
    @DidSetPublished private(set) var hasBeenVisited = false
    @DidSetPublished private(set) var locationsArrivedFrom = [Location]()
    public let id: UUID
    
    init() {
        self.bridgeAccessibility = .noBridge
        self.hexagonCoordinate = nil
        self.id = UUID() // Locations refer to next locations by id so ids must remain consistent
        LocationCache.addLocation(self as! Location)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case nextLocationIDs
        case bridgeLocation
        case bridgeAccessibility
        case hexagonCoordinate
        case context
        case hasBeenVisited
        case locationsArrivedFrom
        case id
    }

    required init(dataObject: DataObject) {
        let stringIDs: [String] = dataObject.get(Field.nextLocationIDs.rawValue)
        self.nextLocationIDs = stringIDs.map({ UUID(uuidString: $0)! })
        self.bridgeLocation = dataObject.getObjectOptional(Field.bridgeLocation.rawValue, type: BridgeLocation.self)
        self.bridgeAccessibility = LocationBridgeAccessibility(rawValue: dataObject.get(Field.bridgeAccessibility.rawValue)) ?? .noBridge
        self.hexagonCoordinate = dataObject.getObjectOptional(Field.hexagonCoordinate.rawValue, type: HexagonCoordinate.self)
        self.context = dataObject.getObject(Field.context.rawValue, type: LocationContext.self)
        self.hasBeenVisited = dataObject.get(Field.hasBeenVisited.rawValue, onFail: false)
        self.locationsArrivedFrom = dataObject.getObjectArray(Field.locationsArrivedFrom.rawValue, type: LocationAbstract.self) as! [any Location]
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        LocationCache.addLocation(self as! Location)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.nextLocationIDs.rawValue, value: self.nextLocationIDs.map({ $0.uuidString }))
            .add(key: Field.bridgeLocation.rawValue, value: self.bridgeLocation)
            .add(key: Field.bridgeAccessibility.rawValue, value: self.bridgeAccessibility.rawValue)
            .add(key: Field.hexagonCoordinate.rawValue, value: self.hexagonCoordinate)
            .add(key: Field.context.rawValue, value: self.context)
            .add(key: Field.hasBeenVisited.rawValue, value: self.hasBeenVisited)
            .add(key: Field.locationsArrivedFrom.rawValue, value: self.locationsArrivedFrom as [LocationAbstract])
            .add(key: Field.id.rawValue, value: self.id.uuidString)
    }

    // MARK: - Functions
    
    func setToVisited(from location: Location) {
        self.hasBeenVisited = true
        self.addLocationArrivedFrom(location)
        if location is BridgeLocation || self is BridgeLocation {
            // Becuase you can travel "backwards" on bridge locations
            location.addLocationArrivedFrom(self as! Location)
        }
    }
    
    func addLocationArrivedFrom(_ location: Location) {
        self.locationsArrivedFrom.append(location)
    }
    
    func addNextLocations(_ locations: [Location]) {
        self.nextLocationIDs.append(contentsOf: locations.map({ $0.id }))
    }
    
    func setBridgeLocation(_ bridgeLocation: BridgeLocation) {
        self.bridgeLocation = bridgeLocation
    }
    
    func setBridgeAccessibility(_ bridgeAccessibility: LocationBridgeAccessibility) {
        assert(self.bridgeAccessibility == .noBridge, "Bridge accessbility has been set more than once, which shouldn't be occuring")
        self.bridgeAccessibility = bridgeAccessibility
    }
    
    func setHexagonCoordinate(_ x: Int, _ y: Int) {
        assert(self.hexagonCoordinate == nil, "Hexagon coordinate has been set more than once, which shouldn't be occuring - set from (\(String(describing: self.hexagonCoordinate?.x)), \(String(describing: self.hexagonCoordinate?.y))) to (\(x), \(y))")
        self.hexagonCoordinate = HexagonCoordinate(x, y)
    }
    
    func setAreaContext(_ area: Area) {
        self.setContext(name: area.name, description: area.description, imageName: area.imageName)
    }
    
    func setContext(name: String, description: String, imageName: String) {
        self.context.setContext(name: name, description: description, imageName: imageName)
    }
    
}
