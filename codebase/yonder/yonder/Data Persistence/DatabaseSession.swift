//
//  DatabaseSession.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation
import SwiftSerialization

class DatabaseSession {
    
    /// Singleton instance
    public static let instance = DatabaseSession()
    
    /// The record ID for saving a game - currently only one game can be saved so it's retrieved
    /// If I wanted to let players to save multiple games, I would read all `read()` to retrieve all `Game` objects
    private static let GAME_RECORD_ID = "gamedata"
    
    /// The database target in use (can be swapped out with any database that conforms to DatabaseTarget)
    private let database: DatabaseTarget = SerializationDatabase()
    
    private init() { }
    
    func writeGame(_ game: Game) -> Bool {
        let record = Record(id: Self.GAME_RECORD_ID, data: game)
        return self.database.write(record)
    }
    
    func readGame() -> Game? {
        return self.database.read(id: Self.GAME_RECORD_ID)
    }
    
}
