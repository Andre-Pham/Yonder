//
//  PlayerStageManager.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

class PlayerStageManager: OnPlayerTravelSubscriber {
    
    private(set) var stage: Int {
        didSet {
            AfterStageChangePublisher.publish(newStage: self.stage)
        }
    }
    private let map: Map
    
    init(map: Map, stage: Int) {
        self.map = map
        self.stage = stage
        
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
