//
//  TavernArea.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class TavernArea {
    
    private(set) var rootLocations = [LocationAbstract]()
    private(set) var tipLocations = [LocationAbstract]()
    public let arrangement: TavernAreaArrangements
    public let locations: [LocationAbstract]
    
    func addRootLocations(_ locations: [LocationAbstract]) {
        self.rootLocations.append(contentsOf: locations)
    }
    
    func addTipLocations(_ locations: [LocationAbstract]) {
        self.tipLocations.append(contentsOf: locations)
    }
    
    func createDirectedEdges(from location: LocationAbstract, to nextLocations: [LocationAbstract]) {
        location.addNextLocations(nextLocations)
    }

}
