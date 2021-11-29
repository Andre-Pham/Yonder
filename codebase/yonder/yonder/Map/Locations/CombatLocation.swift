//
//  CombatLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class CombatLocation: LocationAbstract {
    
    private(set) var foe: FoeAbstract
    public let type: LocationType = .combat
    
    init(foe: FoeAbstract, locationBridgeAccessibility: LocationBridgeAccessibility) {
        self.foe = foe
        
        super.init(locationBridgeAccessibility: locationBridgeAccessibility)
    }
    
}
