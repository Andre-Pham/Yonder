//
//  TerritoryPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class TerritoryPool {
    
    public let stage: Int
    private(set) var areaPools: [AreaPool]
    // tavernAreaPools
    public let id = UUID()
    
    init(stage: Int, areaPools: [AreaPool]) {
        self.stage = stage
        self.areaPools = areaPools
    }
    
    private func removeAreaPool(areaPool: AreaPool) {
        guard let index = (self.areaPools.firstIndex { $0.id == areaPool.id }) else {
            return
        }
        self.areaPools.remove(at: index)
    }
    
    func grabAreaPool() -> AreaPool? {
        if let areaPool = self.areaPools.randomElement() {
            self.removeAreaPool(areaPool: areaPool)
            return areaPool
        }
        YonderDebugging.printError(message: "Area pool has no more areas to grab", functionName: #function, className: "\(type(of: self))")
        return nil
    }
    
}
