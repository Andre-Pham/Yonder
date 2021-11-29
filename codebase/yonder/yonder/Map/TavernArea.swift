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
    
    func addRootLocations(_ locations: [Location]) {
        self.rootLocations.append(contentsOf: locations)
    }
    
    func addTipLocations(_ locations: [Location]) {
        self.tipLocations.append(contentsOf: locations)
    }
    
    func createDirectedEdges(from location: Location, to nextLocations: [Location]) {
        location.addNextLocations(nextLocations)
    }

}
