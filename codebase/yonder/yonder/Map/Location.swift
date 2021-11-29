//
//  Location.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

enum LocationBridgeAccessibility {
    case leftBridge // A bridge can be formed from this node to an area to the left
    case rightBridge // A bridge can be formed from this node to an area to the right
    case noBridge
}

class Location {
    
    private(set) var nextLocations = [Location]()
    private(set) var bridgeLocations = [BridgeLocation]()
    public let bridgeAccessibility: LocationBridgeAccessibility
    
    init(locationBridgeAccessibility: LocationBridgeAccessibility) {
        self.bridgeAccessibility = locationBridgeAccessibility
    }
    
    func addNextLocations(_ locations: [Location]) {
        self.nextLocations.append(contentsOf: locations)
    }
    
    func addBridgeLocation(_ bridgeLocation: BridgeLocation) {
        self.bridgeLocations.append(bridgeLocation)
    }
    
}
