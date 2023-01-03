//
//  GameContext.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

class GameContext {
    
    public let turnManager: TurnManager
    public let stableGameStateManager: StableGameStateManager
    public let playerStageManager: PlayerStageManager
    
    init(map: Map, stage: Int = 0) {
        self.turnManager = TurnManager()
        self.stableGameStateManager = StableGameStateManager()
        self.playerStageManager = PlayerStageManager(map: map, stage: stage)
    }
    
}
