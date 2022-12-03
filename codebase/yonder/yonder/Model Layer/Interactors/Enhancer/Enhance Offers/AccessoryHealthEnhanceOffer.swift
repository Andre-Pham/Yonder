//
//  AccessoryHealthEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class AccessoryHealthEnhanceOffer: EnhanceOffer {
    
    private let health: Int
    
    init(price: Int, health: Int) {
        self.health = health
        super.init(
            price: price,
            name: Strings("enhanceOffer.accessoryHealth.name").local,
            description: Strings("enhanceOffer.accessoryHealth.description1Param").localWithArgs(health)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case health
    }

    required init(dataObject: DataObject) {
        self.health = dataObject.get(Field.health.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.health.rawValue, value: self.health)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            accessory.adjustHealthBonus(by: self.health)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
