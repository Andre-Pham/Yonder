//
//  BridgeLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class BridgeLocation {
    
    private(set) var adjacentLocations = [LocationAbstract]()
    
    func addAdjacentLocation(_ location: LocationAbstract) {
        self.adjacentLocations.append(location)
    }
    
}
