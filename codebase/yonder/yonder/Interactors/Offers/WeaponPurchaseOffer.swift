//
//  WeaponPurchaseOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PurchaseWeaponOffer: Offer {
    
    public let id: UUID = UUID()
    public let weapon: Weapon
    public let price: Int
    
    init(weapon: Weapon, price: Int) {
        self.weapon = weapon
        self.price = price
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: -self.price)
        player.addWeapon(self.weapon)
    }
    
}
