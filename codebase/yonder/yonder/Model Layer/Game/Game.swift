//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Game {
    
    private(set) var map: Map
    private(set) var player: Player
    public let gameContext: GameContext
    public let turnManager = TurnManager()
    
    init() {
        self.map = MapFactory().deliver() // Testing: TestContent.newMap()
        self.player = Player(maxHealth: 500, location: self.map.startingLocation)
        self.gameContext = GameContext(map: self.map)
    }
    
}
