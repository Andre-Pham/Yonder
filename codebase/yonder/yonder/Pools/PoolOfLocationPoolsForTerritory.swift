//
//  TerritoryPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation


// Pool of AreaPools and TavernAreas to create a Territory
class TerritoryPool {
    
    private(set) var areaPools: [AreaPool]
    private(set) var tavernAreaPool: [TavernArea]
    public let id = UUID()
    
    init(areaPools: [AreaPool], tavernAreas: [TavernArea]) {
        self.areaPools = areaPools
        self.tavernAreaPool = tavernAreas
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
    
    func grabTavernArea() -> TavernArea? {
        return self.tavernAreaPool.randomElement()
    }
    
}
