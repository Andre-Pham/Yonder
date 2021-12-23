//
//  MapPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class MapPool {
    
    private(set) var territoryPoolsInStageOrder: [TerritoryPool]
    
    init(territoryPoolsInStageOrder: [TerritoryPool]) {
        self.territoryPoolsInStageOrder = territoryPoolsInStageOrder
    }
    
    private func removeTerritoryPool(stage: Int) {
        self.territoryPoolsInStageOrder.remove(at: stage)
    }
    
    func grabTerritoryPool(stage: Int) -> TerritoryPool? {
        if self.territoryPoolsInStageOrder.count-1 >= stage {
            let territory = self.territoryPoolsInStageOrder[stage]
            self.removeTerritoryPool(stage: stage)
            return territory
        }
        YonderDebugging.printError(message: "Territory pool missing territory to grab", functionName: #function, className: "\(type(of: self))")
        return nil
    }
    
}
