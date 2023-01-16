//
//  PlayerStageManager.swift
//  yonder
//
//  Created by Andre Pham on 23/12/2022.
//

import Foundation

class PlayerStageManager: OnPlayerTravelSubscriber, Storable {
    
    private(set) var stage: Int {
        didSet {
            AfterStageChangePublisher.publish(newStage: self.stage)
        }
    }
    
    init(stage: Int) {
        self.stage = stage
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        let map = Game.gameContextAccess.map
        let territory = map.territoriesInOrder[self.stage + 1]
        if territory.rootLocations.contains(where: { $0.id == newLocation.id }) {
            self.stage += 1
        }
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
    
}
