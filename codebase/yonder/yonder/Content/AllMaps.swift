//
//  AllMaps.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Maps {
    
    static func newMap() -> Map {
        let mapPool = MapPool(territoryPoolsInStageOrder: [
            TerritoryPool(
                areaPools: AREA_POOLS_STAGE_ORDERED[0],
                tavernAreas: [
                    // TavernAreas
                ])
        ])
        
        return Generators.generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
