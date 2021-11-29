//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

var GAME = Game()

class Game {
    
    private(set) var player = Player(maxHealth: 500)
    private(set) var map = createTestMap() // This should be of type Map
    // player.location = map.startingLocation (or something like this)
    
}
