//
//  Area.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Area {
    
    // In the future, maybe areas will be able to have multiple root and tip locations for even more choice
    public let rootLocation: Location
    public let tipLocation: Location
    private(set) var leftBridgeLocations = [Location]()
    private(set) var rightBridgeLocations = [Location]()
    
    init(rootLocation: Location, tipLocation: Location) {
        self.rootLocation = rootLocation
        self.tipLocation = tipLocation
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
    
}
