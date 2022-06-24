//
//  WeaponPurchaseOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PurchaseWeaponOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let weapon: Weapon
    public let price: Int
    
    init(weapon: Weapon, price: Int) {
        self.name = Strings.Offer.WeaponPurchase.Name.local
        self.description = Strings.Offer.WeaponPurchase.Description2Param.localWithArgs(String(price), weapon.fullSummary)
        self.weapon = weapon
        self.price = price
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: -self.price)
        player.addWeapon(self.weapon)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.canAfford(price: self.price)
    }
    
}
