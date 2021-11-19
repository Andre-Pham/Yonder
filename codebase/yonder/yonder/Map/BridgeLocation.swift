//
//  BridgeLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class BridgeLocation {
    
    private(set) var adjacentLocations = [Location]()
    
    func addAdjacentLocation(_ location: Location) {
        self.adjacentLocations.append(location)
    }
    
}
