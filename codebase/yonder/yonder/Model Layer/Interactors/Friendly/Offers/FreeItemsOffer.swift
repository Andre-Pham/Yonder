//
//  FreeItemsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeItemsOffer: Offer {
    
    public let potions: [Potion]
    public let consumables: [Consumable]
    
    init(potions: [Potion], consumables: [Consumable]) {
        self.potions = potions
        self.consumables = consumables
        let names = (potions.map({ Strings("dotPoint").local.continuedBy($0.name) }) +
                     consumables.map({ Strings("dotPoint").local.continuedBy($0.name) }))
        let namesDescription = names.joined(separator: "\n")
        super.init(
            name: Strings("offer.freeItems.name").local,
            description: Strings("offer.freeItems.description1Param").localWithArgs(namesDescription)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case potions
        case consumables
    }

    required init(dataObject: DataObject) {
        self.potions = dataObject.getObjectArray(Field.potions.rawValue, type: PotionAbstract.self) as! [any Potion]
        self.consumables = dataObject.getObjectArray(Field.consumables.rawValue, type: ConsumableAbstract.self) as! [any Consumable]
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.potions.rawValue, value: self.potions as [PotionAbstract])
            .add(key: Field.consumables.rawValue, value: self.consumables as [ConsumableAbstract])
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        self.potions.forEach({ player.addPotion($0) })
        self.consumables.forEach({ player.addConsumable($0) })
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
