//
//  FreeRestorationOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeRestorationOffer: Offer {
    
    public let restorationAmount: Int
    
    init(restorationAmount: Int) {
        self.restorationAmount = restorationAmount
        super.init(
            name: Strings("offer.freeRestoration.name").local,
            description: Strings("offer.freeRestoration.description1Param").localWithArgs(restorationAmount)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case restorationAmount
    }

    required init(dataObject: DataObject) {
        self.restorationAmount = dataObject.get(Field.restorationAmount.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.restorationAmount.rawValue, value: self.restorationAmount)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.restoreAdjusted(sourceOwner: NoActor(), using: self, for: self.restorationAmount)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !(player.isFullHealth && player.isFullArmorPoints)
    }
    
}
