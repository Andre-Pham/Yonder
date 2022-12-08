//
//  ClericClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class ClericClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.cleric.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 300, location: location)
        // TODO: Implement class
        // lots of healing (staff and potions)
        // thorns armour
        // resistance accessory
        return player
    }
    
}
