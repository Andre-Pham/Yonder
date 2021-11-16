//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

var GAME = Game()

class Game {
    
    public var player = Player(maxHealth: 500)
    public var foe = FoeAbstract(maxHealth: 200, attackDamage: 100)
    
}
