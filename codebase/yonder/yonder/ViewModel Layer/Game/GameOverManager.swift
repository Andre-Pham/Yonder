//
//  GameOverManager.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import Foundation
import SwiftUI

/// This manages the published state on whether it's game over or not to be reacted to by the view layer.
/// Remember, view models are only to be used within the view layer and view model layer, not the model.
class GameOverManager: ObservableObject, AfterGameLoadedSubscriber, AfterPlayerDeathSubscriber {
    
    @Published private(set) var isGameOver = false
    private var overrideGameOver = false
    
    init() {
        if let activeGame = Session.instance.activeGame {
            self.isGameOver = activeGame.player.isDead
        }
        
        AfterGameLoadedPublisher.subscribe(self)
        AfterPlayerDeathPublisher.subscribe(self)
    }
    
    func afterGameLoaded(game: Game) {
        self.overrideGameOver = false
        self.isGameOver = game.player.isDead
    }
    
    func afterPlayerDeath(player: Player) {
        guard !self.overrideGameOver else {
            return
        }
        self.isGameOver = true
    }
    
    func continueAfterGameOver() {
        self.overrideGameOver = true
        self.isGameOver = false
    }
    
}
