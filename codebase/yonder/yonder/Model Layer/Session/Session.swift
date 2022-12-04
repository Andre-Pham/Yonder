//
//  Session.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private(set) var activeGame: Game? = nil {
        didSet {
            if let activeGame = self.activeGame {
                GameManager.instance.setActiveGame(to: activeGame)
            }
        }
    }
    
    private init() { }
    
    func startNewGame() {
        self.activeGame = Game()
        Pricing.instance.setGameContext(to: self.activeGame!.gameContext)
    }
    
    func saveGame() {
        if let game = self.activeGame {
            LocalDatabaseSession.instance.write(game)
        }
    }
    
    func loadGame() {
        self.activeGame = LocalDatabaseSession.instance.read()
    }
    
}
