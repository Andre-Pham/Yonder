//
//  Area.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation
import SwiftUI

class Area: Named, Described, Visualised {
    
    public let name: String
    public let description: String
    public let imageName: String
    public let rootLocation: Location
    public let tipLocation: Location
    private(set) var leftBridgeLocations = [Location]()
    private(set) var rightBridgeLocations = [Location]()
    public let arrangement: AreaArrangements
    public let locations: [Location]
    public let id = UUID()
    var image: Image {
        return Image(self.imageName)
    }
    
    // locations are received from LocationsGenerator
    init(arrangement: AreaArrangements, locations: [Location], name: String = "placeholderName", description: String = "placeholderDescription", imageName: String = YonderImages.placeholderImage.name) {
        assert(locations.count == arrangement.locationCount, "Number of locations provided to generate Area doesn't match expected number for the arrangement")
        self.arrangement = arrangement
        self.locations = locations
        self.rootLocation = locations.first!
        self.tipLocation = locations.last!
        self.name = name
        self.description = description
        self.imageName = imageName
        
        self.locations.forEach { $0.setAreaContext(self) }
        self.generateAreaArrangement()
    }
    
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
