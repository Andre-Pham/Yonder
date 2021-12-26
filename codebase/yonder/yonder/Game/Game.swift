//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

var GAME = Game()

class Game {
    
    private(set) var map: Map
    private(set) var player: Player
    
    init() {
        self.map = Maps.newMap()
        self.player = Player(maxHealth: 500, location: self.map.startingLocation)
    }
    
}
