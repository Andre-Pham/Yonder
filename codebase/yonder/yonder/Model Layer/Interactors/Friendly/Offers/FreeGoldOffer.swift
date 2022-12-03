//
//  GoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class FreeGoldOffer: Offer {
    
    public let goldAmount: Int
    
    init(goldAmount: Int) {
        self.goldAmount = goldAmount
        super.init(
            name: Strings("offer.freeGold.name").local,
            description: Strings("offer.freeGold.description1Param").localWithArgs(goldAmount)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case goldAmount
    }

    required init(dataObject: DataObject) {
        self.goldAmount = dataObject.get(Field.goldAmount.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.goldAmount.rawValue, value: self.goldAmount)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldAmount)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
