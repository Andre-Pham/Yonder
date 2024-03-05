//
//  GoldAfterTravelEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

/// After every travel, gain some gold.
class GoldAfterTravelEquipmentPill: EquipmentPill, OnPlayerTravelSubscriber {
    
    private let goldReceived: Int
    
    init(goldReceived: Int, sourceName: String) {
        self.goldReceived = goldReceived
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.goldAfterTravel.effectsDescription1Param").localWithArgs(goldReceived)
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.goldReceived = original.goldReceived
        
        super.init(original)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case goldReceived
    }

    required init(dataObject: DataObject) {
        self.goldReceived = dataObject.get(Field.goldReceived.rawValue)
        super.init(dataObject: dataObject)
        
        OnPlayerTravelPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.goldReceived.rawValue, value: self.goldReceived)
    }

    // MARK: - Functions
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        if player.hasEquipmentEffect(self) {
            player.modifyGoldAdjusted(by: self.goldReceived)
        }
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return self.goldReceived*Pricing.Stat.infiniteDuration
        case .foe:
            // Foes don't travel
            return 0
        }
    }
    
}
