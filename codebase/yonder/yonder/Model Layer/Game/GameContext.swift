//
//  GameContext.swift
//  yonder
//
//  Created by Andre Pham on 5/10/2022.
//

import Foundation

class GameContext: OnPlayerTravelSubscriber {
    
    private(set) var stage: Int
    private let map: Map
    
    init(map: Map) {
        self.map = map
        self.stage = 0
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        let territory = self.map.territoriesInOrder[self.stage]
        if territory.tavernArea.tipLocations.contains(where: { $0.id == player.location.id }) && !territory.tavernArea.locations.contains(where: { $0.id == newLocation.id }) {
            // The player was at a tip location in the tavern area but now is no longer in the tavern area
            // Hence the player has exited the tavern area
            self.stage += 1
        }
    }
    
}
