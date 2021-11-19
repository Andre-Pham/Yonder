//
//  Area.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Area {
    
    // In the future, maybe areas will be able to have multiple root and tip locations for even more choice
    public let rootLocation: Location
    public let tipLocation: Location
    
    init(rootLocation: Location, tipLocation: Location) {
        self.rootLocation = rootLocation
        self.tipLocation = tipLocation
    }
    
    func addNextLocation(from location: Location, to nextLocation: Location) {
        location.addNextLocation(nextLocation)
    }
    
}
