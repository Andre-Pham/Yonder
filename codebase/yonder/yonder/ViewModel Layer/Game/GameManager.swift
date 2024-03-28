//
//  GameManager.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import Foundation

/// This manages the current game used within the viewmodel layer and generates the player and player location view models (which in turn generate subsequent view models).
/// Remember, view models are only to be used within the view layer and view model layer, not the model.
class GameManager {
    
    /// Singleton instance
    static let instance = GameManager()
    
    // These should only be accessed after an active game is set
    private var activeGame: Game? = nil
    private var internalPlayerVM: PlayerViewModel? = nil
    private var internalPlayerLocationVM: PlayerLocationViewModel? = nil
    var playerVM: PlayerViewModel {
        self.internalPlayerVM!
    }
    var playerLocationVM: PlayerLocationViewModel {
        self.internalPlayerLocationVM!
    }
    var foeViewModel: FoeViewModel? {
        return self.playerLocationVM.locationViewModel.getFoeViewModel()
    }
    
    private init() {
        // If a preview is being executed, generate a game to preview
        if SessionEnvironment.executingSwiftUIPreview {
            self.setActiveGame(to: TestContent.testGame())
        }
    }
    
    func setActiveGame(to game: Game) {
        self.activeGame = game
        self.internalPlayerVM = PlayerViewModel(self.activeGame!.player)
        self.internalPlayerLocationVM = PlayerLocationViewModel(player: self.activeGame!.player)
    }
    
    func getMapLocationConnections(gridDimensions: GridDimensions) -> [LocationConnection?] {
        return LocationConnectionGenerator(map: self.activeGame!.map, hexagonCount: gridDimensions.hexagonCount, columnsCount: gridDimensions.columnsCount).getAllLocationConnections()
    }
    
}
