//
//  WarlockClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class WarlockClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.warlock.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 120, location: location)
        // TODO: Implement class
        // no armour
        // a strong lifesteal weapon
        // accessory that gives damage resistance and damage buff
        return player
    }
    
}
