//
//  Area.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Area {
    
    // In the future, maybe areas will be able to have multiple root and tip locations for even more choice
    public let rootLocation: LocationAbstract
    public let tipLocation: LocationAbstract
    private(set) var leftBridgeLocations = [LocationAbstract]()
    private(set) var rightBridgeLocations = [LocationAbstract]()
    
    init(rootLocation: LocationAbstract, tipLocation: LocationAbstract) {
        self.rootLocation = rootLocation
        self.tipLocation = tipLocation
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
    
}
