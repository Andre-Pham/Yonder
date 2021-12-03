//
//  WeaponPurchaseOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PurchaseWeaponOffer: Offer {
    
    public let id: UUID = UUID()
    public let weapon: WeaponAbstract
    public let price: Int
    
    init(weapon: WeaponAbstract, price: Int) {
        self.weapon = weapon
        self.price = price
    }
    
    func acceptOffer(player: Player) {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: player, price: self.price)
        player.adjustGold(by: -adjustedPrice)
        player.addWeapon(self.weapon)
    }
    
}
