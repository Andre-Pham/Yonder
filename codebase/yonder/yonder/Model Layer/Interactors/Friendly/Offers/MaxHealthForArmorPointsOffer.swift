//
//  MaxHealthForArmorPointsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class MaxHealthForArmorPointsOffer: Offer {
    
    init() {
        super.init(
            name: Strings("offer.maxHealthForArmorPoints.name").local,
            description: Strings("offer.maxHealthForArmorPoints.description").local
        )
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        for armorPiece in player.allArmorPieces {
            let amount = armorPiece.armorPoints
            armorPiece.adjustArmorPoints(by: amount)
            player.restoreArmorPoints(for: amount)
        }
        player.adjustMaxHealth(by: -(Double(player.maxHealth)/2.0).toRoundedInt())
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.armorPoints > 0
    }
    
}
