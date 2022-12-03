//
//  HealthForGoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import Foundation

class HealthForGoldOffer: Offer {
    
    public let health: Int
    public let goldReward: Int
    
    init(health: Int, goldReward: Int) {
        self.health = health
        self.goldReward = goldReward
        super.init(
            name: Strings("offer.healthForGold.name").local,
            description: Strings("offer.healthForGold.description2Param").localWithArgs(health, goldReward)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case health
        case goldReward
    }

    required init(dataObject: DataObject) {
        self.health = dataObject.get(Field.health.rawValue)
        self.goldReward = dataObject.get(Field.goldReward.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.health.rawValue, value: self.health)
            .add(key: Field.goldReward.rawValue, value: self.goldReward)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldReward)
        player.damageHealth(for: self.health)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        // If the player wants to, let them
        // Provides opportunities for phoenix abilities too
        return true
    }
    
}
