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
    
    init(territoriesInOrder: [Territory], bossAreasInOrder: [BossArea]) {
        self.territoriesInOrder = territoriesInOrder
        self.bossAreasInOrder = bossAreasInOrder
        self.startingLocation = NoLocation()
        assert(self.territoriesInOrder.count > 0, "No territories were defined for the map")
        assert(self.bossAreasInOrder.count > 0, "No bosses were defined for the map")
        assert(self.territoriesInOrder.count%Self.territoriesPerBoss == 0, "The multiple of territories provided don't match the expected amount to ensure that for every boss, there are \(Self.territoriesPerBoss) territories")
        assert(self.territoriesInOrder.count == self.bossAreasInOrder.count*Self.territoriesPerBoss, "Number of bosses doesn't correspond to number of territories defined for the map")
        
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
