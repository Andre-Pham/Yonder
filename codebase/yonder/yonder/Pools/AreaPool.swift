//
//  AreaPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class AreaPool {
    
    public let areaName: String
    public let locationsPool: AreaLocationsPool
    public let id = UUID()
    
    init(areaName: String, locationsPool: AreaLocationsPool) {
        self.areaName = areaName
        self.locationsPool = locationsPool
    }
    
}
