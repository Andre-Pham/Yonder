//
//  DoubleWeaponArmorPointsRestorationEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 27/11/2022.
//

import Foundation

class DoubleWeaponArmorPointsRestorationEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    
    init(price: Int) {
        self.price = price
        self.name = Strings("enhanceOffer.doubleWeaponArmorPointsRestoration.name").local
        self.description = Strings("enhanceOffer.doubleWeaponArmorPointsRestoration.description").local
    }
    
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
