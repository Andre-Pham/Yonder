//
//  BossLocation.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossLocation: LocationAbstract, FoeLocation {
    
    private(set) var foe: Foe
    public let type: LocationType = .boss
    
    init(boss: Foe) {
        self.foe = boss
    }
    
}
