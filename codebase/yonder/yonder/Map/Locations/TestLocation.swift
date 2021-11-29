//
//  TestLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class TestLocation: LocationAbstract {
    
    var type: LocationType = .none
    
    override init(locationBridgeAccessibility: LocationBridgeAccessibility) {
        super.init(locationBridgeAccessibility: locationBridgeAccessibility)
    }
    
}
