//
//  HostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class HostileLocation: Location, FoeLocation {
    
    private(set) var foe: Foe
    public let type: LocationType = .hostile
    
    init(foe: Foe) {
        self.foe = foe
    }
    
}
