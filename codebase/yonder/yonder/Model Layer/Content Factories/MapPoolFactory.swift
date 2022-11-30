//
//  MapPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class MapPoolFactory {
    
    func deliver() -> MapPool {
        let territoryPoolFactory = TerritoryPoolFactory()
        let bossAreaPoolFactory = BossAreaPoolFactory()
        let mapPool = MapPool(
            territoryPoolsInStageOrder: territoryPoolFactory.deliver(count: MapConfig.territoryCount),
            bossAreaPoolsInOrder: bossAreaPoolFactory.deliver(count: MapConfig.bossCount)
        )
        return mapPool
    }
    
}
