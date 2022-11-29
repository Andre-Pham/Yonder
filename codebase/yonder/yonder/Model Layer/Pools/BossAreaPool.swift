//
//  BossAreaPool.swift
//  yonder
//
//  Created by Andre Pham on 30/11/2022.
//

import Foundation

// Pool of BossLocations and RestorerLocations to create a BossArea
class BossAreaPool {
    
    private(set) var bossLocations: [BossLocation]
    private(set) var restorerLocations: [RestorerLocation]
    public let id = UUID()
    
    init(bossLocations: [BossLocation], restorerLocations: [RestorerLocation]) {
        self.bossLocations = bossLocations
        self.restorerLocations = restorerLocations
    }
    
    func grabBossLocation() -> BossLocation {
        // No need to remove boss from array
        // Boss areas only have 1 boss, so there's no chance of grabbing the same one twice
        return self.bossLocations.randomElement()!
    }
    
    func grabRestorerLocation() -> RestorerLocation {
        // No need to remove restorer from array
        // Boss areas only have 1 restorer, so there's no chance of grabbing the same one twice
        return self.restorerLocations.randomElement()!
    }
    
}
