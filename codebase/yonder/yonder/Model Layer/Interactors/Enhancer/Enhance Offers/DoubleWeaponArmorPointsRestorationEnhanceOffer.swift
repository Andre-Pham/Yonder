//
//  DoubleWeaponArmorPointsRestorationEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 27/11/2022.
//

import Foundation

class DoubleWeaponArmorPointsRestorationEnhanceOffer: EnhanceOffer {
    
    init(price: Int) {
        super.init(
            price: price,
            name: Strings("enhanceOffer.doubleWeaponArmorPointsRestoration.name").local,
            description: Strings("enhanceOffer.doubleWeaponArmorPointsRestoration.description").local
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
            
            weapon.adjustArmorPointsRestoration(by: weapon.armorPointsRestoration)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
