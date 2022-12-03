//
//  SellPotionsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class SellPotionsOffer: Offer {
    
    init() {
        super.init(
            name: Strings("offer.sellPotions.name").local,
            description: Strings("offer.sellPotions.description").local
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
        let fairValue = player.potions.map({ $0.getBasePurchasePrice() }).reduce(0, +)
        player.modifyGoldAdjusted(by: 3*fairValue)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.potions.isEmpty
    }
    
}
