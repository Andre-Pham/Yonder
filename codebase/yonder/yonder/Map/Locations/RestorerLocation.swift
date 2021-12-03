//
//  RestorerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class RestorerLocation: LocationAbstract {
    
    private(set) var restorer: Restorer
    public let type: LocationType = .restorer
    
    init(restorer: Restorer, locationBridgeAccessibility: LocationBridgeAccessibility) {
        self.restorer = restorer
        
        super.init(locationBridgeAccessibility: locationBridgeAccessibility)
    }
    
}
