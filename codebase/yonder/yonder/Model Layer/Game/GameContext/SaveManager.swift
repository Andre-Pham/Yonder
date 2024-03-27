//
//  SaveManager.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import Foundation

/// Manages save triggers that occur relating to game actions.
/// Subscribes to certain game events to detect when an automatic quick-save should be done.
/// Does NOT manage all game saves. Only those related to game actions.
/// Player quick-saves in settings? NOT SaveManager.
/// Player closes or refreshes the app? NOT SaveManager.
/// Player does something in-game, and we want to save in the background while the user plays in case of a crash or fatal error? This is what this is for.
/// Player does something in-game that returns them to the main menu (i.e. player death)? This is what this is for.
class SaveManager: AfterPlayerTravelSubscriber, AfterPlayerDeathSubscriber {
    
    init() {
        AfterPlayerTravelPublisher.subscribe(self)
        AfterPlayerDeathPublisher.subscribe(self)
    }
    
    func afterPlayerTravel(player: Player) {
        DispatchQueue.global().async {
            Session.instance.saveGame()
        }
    }
    
    func afterPlayerDeath(player: Player) {
        DispatchQueue.global().async {
            Session.instance.saveGame()
        }
    }
    
    // If you wanted to be REALLY thorough with saving, how would you go about it?
    // You would save every time a stable game state was reached
    // (See StableGameStateManager)
    // However that's way overkill - even this class is only for in the case of a fatal crash or device shutdown
    // For 99.9% of cases we rely on Session automatically saving when the app is exited (or moves to the background, etc.)
    
}
