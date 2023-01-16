//
//  Game.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Game: Storable {
    
    // MARK: - Singleton
    
    /// This forces the fact that only one game instance can occur at once
    /// Multiple game instances would cause publishers to trigger for every game instance
    private static var instance: Game? = nil {
        didSet {
            if let game = Self.instance {
                AfterGameContextInitPublisher.publish(gameContext: game.gameContext)
            }
        }
    }
    
    /// WARNING: This should only be accessed from within the GameContext directory
    /// Content within the game (player, map, loot, etc.) shouldn't access this - it creates a circular dependency.
    /// This is necessary for sharing information between contexts without merging them into one massive file. It also allows for the contexts to read the map without serialising it.
    public static var gameContextAccess: Game {
        return Self.instance!
    }
    
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
        self.gameContext = GameContext()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case map
        case player
        case gameContext
    }

    required init(dataObject: DataObject) {
        self.map = dataObject.getObject(Field.map.rawValue, type: Map.self)
        self.player = dataObject.getObject(Field.player.rawValue, type: Player.self)
        self.gameContext = dataObject.getObject(Field.gameContext.rawValue, type: GameContext.self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.map.rawValue, value: self.map)
            .add(key: Field.player.rawValue, value: self.player)
            .add(key: Field.gameContext.rawValue, value: self.gameContext)
    }
    
}
