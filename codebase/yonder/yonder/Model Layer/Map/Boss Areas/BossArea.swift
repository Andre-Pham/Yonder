//
//  BossArea.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossArea {
    
    public let bossLocation: BossLocation
    public let restorerLocation: RestorerLocation
    public var locations: [Location] {
        return [self.bossLocation, self.restorerLocation]
    }
    public var rootLocations: [Location] {
        return [self.bossLocation]
    }
    public var tipLocations: [Location] {
        return [self.restorerLocation]
    }
    
    init(bossLocation: BossLocation, restorerLocation: RestorerLocation) {
        self.bossLocation = bossLocation
        self.restorerLocation = restorerLocation
        
        self.bossLocation.addNextLocations([restorerLocation])
        self.bossLocation.setHexagonCoordinate(5, 33)
        self.restorerLocation.setHexagonCoordinate(5, 35)
    }
    
}
