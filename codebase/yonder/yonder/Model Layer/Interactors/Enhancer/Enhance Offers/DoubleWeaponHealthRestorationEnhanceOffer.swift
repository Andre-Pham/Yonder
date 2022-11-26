//
//  DoubleWeaponHealthRestorationEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class DoubleWeaponHealthRestorationEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    
    init(price: Int) {
        self.price = price
        self.name = Strings("enhanceOffer.doubleWeaponHealthRestoration.name").local
        self.description = Strings("enhanceOffer.doubleWeaponHealthRestoration.description").local
    }
    
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
