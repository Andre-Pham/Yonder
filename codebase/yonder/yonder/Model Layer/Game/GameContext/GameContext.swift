//
//  GameContext.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

class GameContext: Storable {
    
    public let turnManager: TurnManager
    public let stableGameStateManager: StableGameStateManager
    public let playerStageManager: PlayerStageManager
    public let contentManager: ContentManager
    
    init() {
        self.turnManager = TurnManager()
        self.stableGameStateManager = StableGameStateManager()
        self.playerStageManager = PlayerStageManager(stage: 0)
        self.contentManager = ContentManager() // Must subscribe after playerStageManager so stage updates before content
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        // TurnManager and StableGameStateManager aren't serialisable - they carry no state
        case playerStageManager
        case contentManager
    }

    required init(dataObject: DataObject) {
        self.turnManager = TurnManager()
        self.stableGameStateManager = StableGameStateManager()
        self.playerStageManager = dataObject.getObject(Field.playerStageManager.rawValue, type: PlayerStageManager.self)
        self.contentManager = dataObject.getObject(Field.contentManager.rawValue, type: ContentManager.self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.playerStageManager.rawValue, value: self.playerStageManager)
            .add(key: Field.contentManager.rawValue, value: self.contentManager)
    }
    
}
