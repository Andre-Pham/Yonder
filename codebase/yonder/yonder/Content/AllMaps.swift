//
//  AllMaps.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Maps {
    
    static func newMap() -> Map {
        let mapPool = MapPool(
            territoryPoolsInStageOrder: [
                TerritoryPool(
                    areaPools: AREA_POOLS_STAGE_ORDERED[0],
                    tavernAreas: TAVERN_AREAS_STAGE0),
                TerritoryPool(
                    areaPools: AREA_POOLS_STAGE_ORDERED[1],
                    tavernAreas: TAVERN_AREAS_STAGE1),
            ],
            bossAreas: [])
        
        return Generators.generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
