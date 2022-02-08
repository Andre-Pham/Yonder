//
//  HostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class HostileLocation: LocationAbstract, FoeLocation {
    
    private(set) var foe: FoeAbstract
    public let type: LocationType = .hostile
    
    init(foe: FoeAbstract) {
        self.foe = foe
    }
    
}
