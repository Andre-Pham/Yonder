//
//  Territory.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class Territory {
    
    private(set) var segment: Segment
    private(set) var tavernArea: TavernArea
    
    init(segment: Segment, followingTavernArea: TavernArea) {
        self.segment = segment
        self.tavernArea = followingTavernArea
        
        for area in segment.allAreas {
            area.tipLocation.addNextLocations(tavernArea.rootLocations)
        }
    }
    
}
