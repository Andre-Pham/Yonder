//
//  PermanentHealthAfterTravelEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

/// After every travel, gain permanent health.
class PermanentHealthAfterTravelEquipmentPill: EquipmentPill, OnPlayerTravelSubscriber {
    
    private let health: Int
    
    init(health: Int, sourceName: String) {
        self.health = health
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.permanentHealthAfterTravel1Param").localWithArgs(health)
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.health = original.health
        
        super.init(original)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case health
    }

    required init(dataObject: DataObject) {
        self.health = dataObject.get(Field.health.rawValue)
        super.init(dataObject: dataObject)
        
        OnPlayerTravelPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.health.rawValue, value: self.health)
    }

    // MARK: - Functions
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        if player.hasEquipmentEffect(self) {
            player.adjustBonusHealth(by: self.health)
        }
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerPermanentHealthStat.getValue(amount: self.health)*Pricing.Stat.infiniteDuration
        case .foe:
            // Foes don't travel
            return 0
        }
    }
    
}
