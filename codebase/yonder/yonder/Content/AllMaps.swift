//
//  AllMaps.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Maps {
    
    static func newMap() -> Map {
        // AllLocations.swift should define locations; the Pools are defined here
        // AllLocations: all the locations in a location pool (basically an area) should be defined in an enum, that way you can create an array of them via .allCases for the enum
        let mapPool = MapPool(territoryPoolsInStageOrder: [
            TerritoryPool(
                areaPools: [
                    // AreaPools
                ],
                tavernAreas: [
                    // TavernAreas
                ])
        ])
        
        return Generators.generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
