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
    
    init(bossLocation: BossLocation, restorerLocation: RestorerLocation) {
        self.bossLocation = bossLocation
        self.restorerLocation = restorerLocation
        
        self.bossLocation.addNextLocations([restorerLocation])
    }
    
}
