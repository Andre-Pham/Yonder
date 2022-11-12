//
//  FreeWeaponOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeWeaponOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let weapon: Weapon
    
    init(weapon: Weapon) {
        self.name = Strings("offer.freeWeapon.name").local
        self.description = Strings("offer.freeWeapon.description1Param").localWithArgs(weapon.fullSummary)
        self.weapon = weapon
    }
    
    func acceptOffer(player: Player) {
        player.addWeapon(self.weapon)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
