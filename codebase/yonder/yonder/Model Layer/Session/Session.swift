//
//  Session.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation
import SwiftUI

/// The app session, used for the most high level operations. Primarily for starting, loading, and saving the active game.
class Session {
    
    /// Singleton instance
    static let instance = Session()
    
    private(set) var activeGame: Game? = nil {
        didSet {
            if let activeGame = self.activeGame {
                Pricing.instance.setStageManager(to: activeGame.gameContext.playerStageManager)
                GameManager.instance.setActiveGame(to: activeGame)
                AfterGameLoadedPublisher.publish(game: activeGame)
            }
        }
    }
    
    private init() { }
    
    func startNewGame(playerClass: PlayerClassOption) {
        let newGame = Game.new(playerClass: playerClass, map: MapFactory().deliver())
        self.activeGame = newGame
        AfterNewGameStartedPublisher.publish(game: newGame)
    }
    
    @discardableResult
    func saveGame() -> Bool {
        if let game = self.activeGame {
            return DatabaseSession.instance.writeGame(game)
        }
        return false
    }
    
    func loadGame() -> Bool {
        self.activeGame = DatabaseSession.instance.readGame()
        if let activeGame {
            AfterGameResumedPublisher.publish(game: activeGame)
        }
        return self.activeGame != nil
    }
    
    func onAppStateChange(to state: ScenePhase) {
        if state == .inactive {
            DispatchQueue.global().async {
                self.saveGame()
            }
        }
    }
    
}
