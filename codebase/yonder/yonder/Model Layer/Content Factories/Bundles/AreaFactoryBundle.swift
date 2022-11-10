//
//  AreaFactoryBundle.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaFactoryBundle {
    
    public let lootFactories: LootFactoryBundle
    public let foeFactory: FoeFactory
    public let challengeHostileFactory: FoeFactory
    
    init(loot: LootFactoryBundle, foes: FoeFactory, challengeHostiles: FoeFactory) {
        self.lootFactories = loot
        self.foeFactory = foes
        self.challengeHostileFactory = challengeHostiles
    }
    
}
