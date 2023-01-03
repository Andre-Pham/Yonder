//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Game: Storable {
    
    // MARK: - Singleton
    // This forces the fact that only one game instance can occur at once
    // Multiple game instances would cause publishers to trigger for every game instance
    
    private static var instance: Game? = nil
    
    static func new(playerClass: PlayerClassOption, map: Map) -> Game {
        Self.instance = Game(playerClass: playerClass, map: map)
        return Self.instance!
    }
    
    // MARK: - Instance
    
    private(set) var map: Map
    private(set) var player: Player
    public let gameContext: GameContext
    
    private init(playerClass: PlayerClassOption, map: Map) {
        self.map = map
        self.player = playerClass.createPlayer(at: self.map.startingLocation)
        self.gameContext = GameContext(map: self.map)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case map
        case player
        case stage
    }

    required init(dataObject: DataObject) {
        self.map = dataObject.getObject(Field.map.rawValue, type: Map.self)
        self.player = dataObject.getObject(Field.player.rawValue, type: Player.self)
        self.gameContext = GameContext(map: self.map, stage: dataObject.get(Field.stage.rawValue))
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.map.rawValue, value: self.map)
            .add(key: Field.player.rawValue, value: self.player)
            .add(key: Field.stage.rawValue, value: self.gameContext.playerStageManager.stage)
    }
    
}
