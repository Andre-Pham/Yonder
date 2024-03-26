//
//  NoClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class NoClass: PlayerClass {
    
    init() {
        super.init(
            name: Strings("class.none.name").local,
            characterSprite: YonderImages.noClassCharacter
        )
    }
    
    func createPlayer(at location: Location) -> Player {
        return Player(maxHealth: 500, location: location)
    }
    
}
