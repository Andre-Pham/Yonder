//
//  Location.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias LocationAbstract = LocationAbstractPart & LocationTyped

protocol LocationTyped {
    
    var type: LocationType { get }
    
}

class LocationAbstractPart {
    
    private(set) var nextLocations = [LocationAbstract]()
    private(set) var bridgeLocation: BridgeLocation?
    private(set) var bridgeAccessibility: LocationBridgeAccessibility
    private(set) var hexagonCoordinate: HexagonCoordinate?
    private(set) var areaContent = AreaContentContainer()
    @DidSetPublished private(set) var hasBeenVisited = false
    @DidSetPublished private(set) var locationsArrivedFrom = [LocationAbstract]()
    public let id = UUID()
    
    init() {
        self.bridgeAccessibility = .noBridge
        self.hexagonCoordinate = nil
    }
    
    func setToVisited(from location: LocationAbstract) {
        self.hasBeenVisited = true
        self.addLocationArrivedFrom(location)
        if location is BridgeLocation || self is BridgeLocation {
            // Becuase you can travel "backwards" on bridge locations
            location.addLocationArrivedFrom(self as! LocationAbstract)
        }
    }
    
    func addLocationArrivedFrom(_ location: LocationAbstract) {
        self.locationsArrivedFrom.append(location)
    }
    
    func addNextLocations(_ locations: [LocationAbstract]) {
        self.nextLocations.append(contentsOf: locations)
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
    
    func setAreaContent(_ area: Area) {
        self.areaContent.setContent(name: area.name, description: area.description, image: area.image)
    }
    
}
