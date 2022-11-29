//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class Map {
    
    static let territoriesPerBoss = 2
    private(set) var territoriesInOrder: [Territory]
    private(set) var bossAreasInOrder: [BossArea]
    private(set) var startingLocation: Location
    
    // Currently expects territoriesInOrder.count == bossAreasInOrder*2+1, but this will change eventually to support the final boss, and have it so the map ends on a boss, not a singular territory
    init(territoriesInOrder: [Territory], bossAreasInOrder: [BossArea]) {
        self.territoriesInOrder = territoriesInOrder
        self.bossAreasInOrder = bossAreasInOrder
        self.startingLocation = NoLocation()
        assert(self.territoriesInOrder.count > 0, "No territories were defined for the map")
        
        var territoryIndex = 0
        var bossAreaIndex = 0
        var liveTipLocations: [LocationAbstract] = [self.startingLocation]
        while bossAreasInOrder.count > bossAreaIndex {
            if (territoryIndex + bossAreaIndex + 1)%(Self.territoriesPerBoss + 1) == 0 {
                // Attach boss area
                let bossArea = self.bossAreasInOrder[bossAreaIndex]
                for tipLocation in liveTipLocations {
                    tipLocation.addNextLocations(bossArea.rootLocations)
                }
                liveTipLocations = bossArea.tipLocations
                bossAreaIndex += 1
            } else {
                // Attach territory
                let territory = self.territoriesInOrder[territoryIndex]
                for tipLocation in liveTipLocations {
                    tipLocation.addNextLocations(territory.rootLocations)
                }
                liveTipLocations = territory.tipLocations
                territoryIndex += 1
            }
        }
    }
    
    func getPreviousTavernAreaToTerritory(at territoryIndex: Int) -> TavernArea? {
        return territoryIndex > 0 ? self.territoriesInOrder[territoryIndex-1].tavernArea : nil
    }
    
    func getPreviousBossAreaToTerritory(at territoryIndex: Int) -> BossArea? {
        return territoryIndex >= Self.territoriesPerBoss && territoryIndex%Self.territoriesPerBoss == 0 ? self.bossAreasInOrder[territoryIndex/Self.territoriesPerBoss - 1] : nil
    }
    
}
