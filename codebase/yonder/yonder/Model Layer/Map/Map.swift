//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class Map {
    
    private(set) var territoriesInOrder: [Territory]
    private(set) var bossAreasInOrder: [BossArea]
    private(set) var startingLocation: Location
    
    // Currently expects territoriesInOrder.count == bossAreasInOrder*2+1, but this will change eventually to support the final boss, and have it so the map ends on a boss, not a singular territory
    init(territoriesInOrder: [Territory], bossAreasInOrder: [BossArea]) {
        self.territoriesInOrder = territoriesInOrder
        self.bossAreasInOrder = bossAreasInOrder
        self.startingLocation = NoLocation()
        
        assert(self.territoriesInOrder.count > 0, "No territories were defined for the map")
        // Connect the starting location to the first area
        for area in self.territoriesInOrder[0].segment.allAreas {
            self.startingLocation.addNextLocations([area.rootLocation])
        }
        
        // TEMP, until bosses are added in
        for territoryIndex in 0..<self.territoriesInOrder.count-1 {
            let territory = self.territoriesInOrder[territoryIndex]
            let nextTerritory = self.territoriesInOrder[territoryIndex+1]
            
            for tipLocation in territory.tipLocations {
                tipLocation.addNextLocations(nextTerritory.rootLocations)
            }
        }
        
        /*let territoriesPerBoss = 2
        var territoryIndex = 0
        var bossIndex = 0
        var bossesToAddRemaining = bossAreasInOrder.count
        while bossesToAddRemaining > 0 {
            let territory = self.territoriesInOrder[territoryIndex]
            let nextTerritory = self.territoriesInOrder[territoryIndex+1]
            
            if territoryIndex%territoriesPerBoss == 1 {
                // Add boss area in between territories
                let bossArea = self.bossAreasInOrder[bossIndex]
                
                for tipLocation in territory.tipLocations {
                    tipLocation.addNextLocations([bossArea.bossLocation])
                }
                bossArea.restorerLocation.addNextLocations(nextTerritory.rootLocations)
                
                bossesToAddRemaining -= 1
                bossIndex += 1
            }
            else {
                for tipLocation in territory.tipLocations {
                    tipLocation.addNextLocations(nextTerritory.rootLocations)
                }
            }
            
            territoryIndex += 1
        }*/
    }
    
    func getPreviousTavernAreaToTerritory(at territoryIndex: Int) -> TavernArea? {
        return territoryIndex > 0 ? self.territoriesInOrder[territoryIndex-1].tavernArea : nil
    }
    
}
