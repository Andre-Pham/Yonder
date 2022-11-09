//
//  MapPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class MapPoolFactory {
    
    func build() -> MapPool {
        let territoryPoolFactory = TerritoryPoolFactory()
        let mapPool = MapPool(
            territoryPoolsInStageOrder: territoryPoolFactory.deliver(count: 8),
            bossAreas: [
                
            ]
        )
    }
    
}
