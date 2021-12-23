//
//  AllMaps.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Maps {
    
    static func newMap() -> Map {
        /*
         Notes to self:
         - The way the map is generated can be much better organised
         - Refactoring should take place in the future
         - E.g. Why can we define more than one territory pool of the same stage? Then we have to filter to grab one?
         */
        // AllLocations.swift should define locations; the Pools are defined here
        // AllLocations: all the locations in a location pool (basically an area) should be defined in an enum, that way you can create an array of them via .allCases for the enum
        let mapPool = MapPool(territoryPoolsInStageOrder: [
            TerritoryPool(
                areaPools: [
                    AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>),
                    AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>)
                ],
                tavernAreaPool: <#T##TavernAreaPool#>)
        ])
        
        return Generators.generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
