//
//  MageClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class MageClass: PlayerClass {
    
    init() {
        super.init(name: Strings("class.mage.name").local)
    }
    
    func createPlayer(at location: Location) -> Player {
        let player = Player(maxHealth: 120, location: location)
        // TODO: Implement class
        // Low shields armour that buffs damage
        // tome that deals very high damage
        // potions for healing/damage
        // no accessory
        return player
    }
    
}
