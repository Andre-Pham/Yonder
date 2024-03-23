//
//  TavernAreaArrangement.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

/// Represents the arrangement of locations for a tavern area based on the number of locations it has
/// IMPORTANT: This is NOT the types of locations a tavern area may have - that's defined by what's passed in the `TavernArea` initialiser
/// This purely defines the logic for setting up the edges and normalised coordinates for the locations of a tavern area, based on how many there are
/// The actual locations that are passed in (e.g. whether there's a restorer or enhancer or whatnot) is defined in TavernAreaFactory
enum TavernAreaArrangement: String, CaseIterable {
    
    case tiny
    case small
    
    // Note: There used to be other arrangements (medium, large, extra large)
    // It was found that large arrangements gave too much choice and burden on the player
    // Hence all but the small were removed
    // If other arrangements were wished to be added, here is where they'd be added (also in TavernAreaFactory where the locations would be passed in)
    
    var locationCount: Int {
        switch self {
        case .tiny: return 2
        case .small: return 3
        }
    }
    
}

extension TavernArea {
    
    func addRootAndTipLocations() {
        switch self.arrangement {
        case .tiny: 
            self.addRootAndTipLocationsTinyArrangement()
        case .small: 
            self.addRootAndTipLocationsSmallArrangement()
        }
    }
    
    func generateAreaArrangement() {
        switch self.arrangement {
        case .tiny:
            self.generateTinyArrangement()
        case .small:
            self.generateSmallArrangement()
        }
    }
    
    private func addRootAndTipLocationsTinyArrangement() {
        self.addRootLocations(0)
        self.addTipLocations(1)
    }
    
    private func addRootAndTipLocationsSmallArrangement() {
        self.addRootLocations(0)
        self.addTipLocations(2)
    }
    
    private func generateTinyArrangement() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(5, 27)
        
        self.addNextLocations(from: 0, to: 1)
    }
    
    private func generateSmallArrangement() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(4, 26)
        self.locations[2].setHexagonCoordinate(5, 27)
        
        self.addNextLocations(from: 0, to: 1)
        self.addNextLocations(from: 1, to: 2)
    }
    
}
