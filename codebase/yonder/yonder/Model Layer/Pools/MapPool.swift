//
//  MapPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

// Pool of TerritoryPools and BossAreas to create a Map
class MapPool {
    
    private(set) var territoryPoolsInStageOrder: [TerritoryPool]
    private(set) var bossAreas: [BossArea]
    
    init(territoryPoolsInStageOrder: [TerritoryPool], bossAreas: [BossArea]) {
        self.territoryPoolsInStageOrder = territoryPoolsInStageOrder
        self.bossAreas = bossAreas
    }
    
    func grabTerritoryPool(stage: Int) -> TerritoryPool? {
        if self.territoryPoolsInStageOrder.count-1 >= stage {
            // No need to remove territories; there's only one for each stage
            let territory = self.territoryPoolsInStageOrder[stage]
            return territory
        }
        assertionFailure("Territory pool missing territory to grab")
        return nil
    }
    
}
