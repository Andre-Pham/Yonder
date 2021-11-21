//
//  TavernArea.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class TavernArea {
    
    private(set) var rootLocations = [Location]()
    private(set) var tipLocations = [Location]()
    
    func addRootLocation(_ location: Location) {
        self.rootLocations.append(location)
    }
    
    func addTipLocation(_ location: Location) {
        self.tipLocations.append(location)
    }
    
    func createDirectedEdge(from location: Location, to nextLocation: Location) {
        location.addNextLocation(nextLocation)
    }

}
