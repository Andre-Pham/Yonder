//
//  DatabaseSession.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation

class DatabaseSession {
    
    static let instance = DatabaseSession()
    
    /// The database target in use (can be swapped out with any database that conforms to DatabaseTarget)
    private let database: DatabaseTarget = SQLiteDatabase()
    /// The record ID for saving a game - currently only one game can be saved so it's retrieved
    /// If I wanted to let players to save multiple games, I would read all `read()` to retrieve all `Game` objects
    private let gameRecordID = "gamedata"
    
    private init() { }
    
    func writeGame(_ game: Game) -> Bool {
        let record = Record(id: self.gameRecordID, data: game)
        return self.database.write(record)
    }
    
    func readGame() -> Game? {
        return self.database.read(id: self.gameRecordID)
    }
    
}
