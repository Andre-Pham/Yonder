//
//  TestSession.swift
//  yonder
//
//  Created by Andre Pham on 1/1/2023.
//

import Foundation

/// Instantiate this session during tests.
/// If the session isn't instantiated, certain functionalities that rely on game context won't work. For instance, without a game being instantiated, no turn manager is instantiated, meaning end of turn effects won't trigger.
class TestSession {
    
    /// The test session instance.
    /// Assigning this instantiates the static variable and saves it to memory.
    /// Hence this should be saved as a property in test classes so it exists in memory while tests are run.
    public static let instance = TestSession()
    
    public let game: Game = TestContent.testGame()
    
    private init() {
        assertionFailureOutsideUnitTests("This class is only to be used during unit testing")
        Pricing.instance.setStageManager(to: self.game.gameContext.playerStageManager)
    }
    
    /// Force an end turn to trigger end of turn effects.
    func completeTurn(player: Player, playerUsed: Item, foe: Foe) {
        self.game.gameContext.turnManager.completeTurn(player: player, playerUsed: playerUsed, foe: foe)
    }
    
    /// Force an end turn to trigger end of turn effects.
    func completeTurn(player: Player) {
        self.game.gameContext.turnManager.completeTurn(player: player)
    }
    
}
