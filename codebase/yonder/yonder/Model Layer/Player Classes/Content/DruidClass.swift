//
//  DruidClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class DruidClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.druid.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 450, location: location)
        // TODO: Implement class
        return player
    }
    
}
