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
    public let image: Image
    public let rootLocation: LocationAbstract
    public let tipLocation: LocationAbstract
    private(set) var leftBridgeLocations = [LocationAbstract]()
    private(set) var rightBridgeLocations = [LocationAbstract]()
    public let arrangement: AreaArrangements
    public let locations: [LocationAbstract]
    public let id = UUID()
    
    // locations are received from LocationsGenerator
    init(arrangement: AreaArrangements, locations: [LocationAbstract], name: String = "placeholderName", description: String = "placeholderDescription", image: Image = YonderImages.placeholderImage) {
        assert(locations.count == arrangement.locationCount, "Number of locations provided to generate Area doesn't match expected number for the arrangement")
        self.arrangement = arrangement
        self.locations = locations
        self.rootLocation = locations.first!
        self.tipLocation = locations.last!
        self.name = name
        self.description = description
        self.image = image
        
        self.locations.forEach { $0.setAreaContent(self) }
        self.generateAreaArrangement()
    }
    
    func addNextLocations(from location: LocationAbstract, to nextLocations: [LocationAbstract]) {
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
