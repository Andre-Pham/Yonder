//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class Map {
    
    private(set) var territoriesInOrder: [Territory]
    private(set) var startingLocation: LocationAbstract
    
    init(territoriesInOrder: [Territory]) {
        self.territoriesInOrder = territoriesInOrder
        self.startingLocation = TestLocation(locationBridgeAccessibility: .noBridge)
        
        guard self.territoriesInOrder.count > 0 else {
            fatalError("No territories were defined for the map")
        }
        for area in self.territoriesInOrder[0].segment.allAreas {
            self.startingLocation.addNextLocations([area.rootLocation])
        }
    }
    
}
