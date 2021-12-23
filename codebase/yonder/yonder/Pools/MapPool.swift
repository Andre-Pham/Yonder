//
//  MapPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class MapPool {
    
    private(set) var territoryPools: [TerritoryPool]
    
    init(territoryPools: [TerritoryPool]) {
        self.territoryPools = territoryPools
    }
    
    private func removeTerritoryPool(territoryPool: TerritoryPool) {
        guard let index = (self.territoryPools.firstIndex { $0.id == territoryPool.id }) else {
            return
        }
        self.territoryPools.remove(at: index)
    }
    
    func grabTerritoryPool(stage: Int) -> TerritoryPool? {
        let grabbableTerritories = self.territoryPools.filter { $0.stage == stage }
        if let territoryPool = grabbableTerritories.randomElement() {
            self.removeTerritoryPool(territoryPool: territoryPool)
            return territoryPool
        }
        YonderDebugging.printError(message: "Territory pool has no more territories to grab", functionName: #function, className: "\(type(of: self))")
        return nil
    }
    
}
