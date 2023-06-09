//
//  PlayerStageManager.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

class PlayerStageManager: Storable, OnPlayerTravelSubscriber {
    
    private(set) var stage: Int {
        didSet {
            AfterStageChangePublisher.publish(newStage: self.stage)
        }
    }
    
    init(stage: Int) {
        self.stage = stage
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case stage
    }

    required init(dataObject: DataObject) {
        self.stage = dataObject.get(Field.stage.rawValue)
        
        OnPlayerTravelPublisher.subscribe(self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.stage.rawValue, value: self.stage)
    }
    
    // MARK: - Functions
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        let map = Game.gameContextAccess.map
        // Stage changes will only trigger in territories (not boss areas)
        for (correspondingStage, territory) in map.territoriesInOrder.enumerated() {
            if territory.allLocations.contains(where: { $0.id == newLocation.id }) {
                if self.stage != correspondingStage {
                    self.stage = correspondingStage
                }
                break
            }
        }
        
        // NOTE: This is much more efficient, but less flexible
        // - Stage changes only occur specifically when crossing into the next territory via its root location
        // - Doesn't allow for skipping territories, making testing more difficult
        // - If the player is ever able to "jump" locations, this becomes very problematic
        // - Can't go backwards in stage
        /*let map = Game.gameContextAccess.map
        let territory = map.territoriesInOrder[self.stage + 1]
        if territory.rootLocations.contains(where: { $0.id == newLocation.id }) {
            self.stage += 1
        }*/
    }
    
}
