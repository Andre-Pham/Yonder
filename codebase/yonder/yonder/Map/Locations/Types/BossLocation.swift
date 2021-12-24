//
//  BossLocation.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossLocation: LocationAbstract {
    
    private(set) var boss: FoeAbstract
    public let type: LocationType = .boss
    
    init(boss: FoeAbstract) {
        self.boss = boss
    }
    
}
