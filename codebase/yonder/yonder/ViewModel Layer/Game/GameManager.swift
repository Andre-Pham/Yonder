//
//  GameManager.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import Foundation

/// This manages the current game instance and generates the player and player location view models (which in turn generate subsequent view models).
/// Remember, view models are only to be used within the view layer and view model layer, not the model.
class GameManager {
    
    static let instance = GameManager()
    
    private var activeGame: Game
    private(set) var playerVM: PlayerViewModel
    private(set) var playerLocationVM: PlayerLocationViewModel
    var foeViewModel: FoeViewModel? {
        return self.playerLocationVM.locationViewModel.getFoeViewModel()
    }
    
    private init() {
        self.activeGame = Game()
        self.playerVM = PlayerViewModel(self.activeGame.player)
        self.playerLocationVM = PlayerLocationViewModel(player: self.activeGame.player)
    }
    
    func startNewGame() {
        self.setActiveGame(to: Game())
    }
    
    func setActiveGame(to game: Game) {
        self.activeGame = game
        self.playerVM = PlayerViewModel(self.activeGame.player)
        self.playerLocationVM = PlayerLocationViewModel(player: self.activeGame.player)
    }
    
    func getMapLocationConnections(gridDimensions: GridDimensions) -> [LocationConnection?] {
        return LocationConnectionGenerator(map: self.activeGame.map, hexagonCount: gridDimensions.hexagonCount, columnsCount: gridDimensions.columnsCount).getAllLocationConnections()
    }
    
}
