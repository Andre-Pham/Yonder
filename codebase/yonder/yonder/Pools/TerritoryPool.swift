//
//  AreaLocationsPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class AreaLocationsPool {
    
    private(set) var areaPools: [LocationsPool]
    private(set) var tavernAreaPool: TavernAreaPool
    public let id = UUID()
    
    init(areaPools: [LocationsPool], tavernAreaPool: TavernAreaPool) {
        self.areaPools = areaPools
        self.tavernAreaPool = tavernAreaPool
    }
    
    private func removeAreaPool(areaPool: LocationsPool) {
        guard let index = (self.areaPools.firstIndex { $0.id == areaPool.id }) else {
            return
        }
        self.areaPools.remove(at: index)
    }
    
    func grabAreaPool() -> LocationsPool? {
        if let areaPool = self.areaPools.randomElement() {
            self.removeAreaPool(areaPool: areaPool)
            return areaPool
        }
        YonderDebugging.printError(message: "Area pool has no more areas to grab", functionName: #function, className: "\(type(of: self))")
        return nil
    }
    
    func grabTavernArea() -> TavernArea? {
        return self.tavernAreaPool.grabTavernArea()
    }
    
}
