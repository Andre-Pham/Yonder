//
//  DoubleWeaponHealthRestorationEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class DoubleWeaponHealthRestorationEnhanceOffer: EnhanceOffer {
    
    init(price: Int) {
        super.init(
            price: price,
            name: Strings("enhanceOffer.doubleWeaponHealthRestoration.name").local,
            description: Strings("enhanceOffer.doubleWeaponHealthRestoration.description").local
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
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustHealthRestoration(by: weapon.healthRestoration)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
