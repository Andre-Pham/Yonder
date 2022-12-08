//
//  PaladinClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class PaladinClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.paladin.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 450, location: location)
        // TODO: Implement class
        // high health
        // high healing
        // regular weapon
        // phoenix accessory
        return player
    }
    
}
