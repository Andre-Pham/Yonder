//
//  GameManager.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import Foundation

/// This manages the current game instance and generates the player and player location view models (which in turn generate subsequent view models).
/// Remember, view models are only to be used within the view layer and view model layer, not the model.
var gameManager = GameManager()
class GameManager {
    
    private var activeGame = Game()
    var playerVM: PlayerViewModel {
        return PlayerViewModel(self.activeGame.player)
    }
    var playerLocationVM: PlayerLocationViewModel {
        return PlayerLocationViewModel(player: self.activeGame.player)
    }
    
    func setActiveGame(to game: Game) {
        self.activeGame = game
    }
    
    func getMapLocationConnections(gridDimensions: GridDimensions) -> [LocationConnection?] {
        return LocationConnectionGenerator(map: self.activeGame.map, hexagonCount: gridDimensions.hexagonCount, columnsCount: gridDimensions.columnsCount).getAllLocationConnections()
    }
    
}
