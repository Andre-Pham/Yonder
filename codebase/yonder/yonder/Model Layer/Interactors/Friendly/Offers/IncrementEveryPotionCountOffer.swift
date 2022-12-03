//
//  IncrementEveryPotionCountOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class IncrementEveryPotionCountOffer: Offer {
    
    public let amount: Int
    
    init(increment: Int) {
        self.amount = increment
        assert(increment > 0, "Negative or 0 increment is not permitted")
        super.init(
            name: Strings("offer.incrementEveryPotionCount.name").local,
            description: Strings("offer.incrementEveryPotionCount.description1Param").localWithArgs(increment)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case amount
    }

    required init(dataObject: DataObject) {
        self.amount = dataObject.get(Field.amount.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.amount.rawValue, value: self.amount)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        for potion in player.potions {
            potion.adjustRemainingUses(by: self.amount)
        }
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.potions.isEmpty
    }
    
}
