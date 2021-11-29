//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class Map {
    
    private(set) var territoriesInOrder: [Territory]
    private(set) var startingLocation: Location // Attach this to the first territory
    
    init(territoriesInOrder: [Territory]) {
        self.territoriesInOrder = territoriesInOrder
        self.startingLocation = Location(locationBridgeAccessibility: .noBridge)
    }
    
}
