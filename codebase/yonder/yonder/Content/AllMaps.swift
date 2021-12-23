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
        let mapPool = MapPool(territoryPools: [
            TerritoryPool(stage: 0,
                          areaPools: [
                            AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>),
                            AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>),
                            AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>)
                          ],
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 1,
                          areaPools: [
                            AreaPool(areaName: <#T##String#>, locationsPool: <#T##AreaLocationsPool#>)
                          ],
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 2,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 3,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 4,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 5,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 6,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 7,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 8,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>),
            TerritoryPool(stage: 9,
                          areaPools: <#T##[AreaPool]#>,
                          tavernAreaPool: <#T##TavernAreaPool#>)
        ])
        
        return Generators.generateTerritoriesIntoMap(mapPool: mapPool, bossesCount: 4)
    }
    
}
