//
//  BuffEveryWeaponDamageOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class BuffEveryWeaponDamageOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let damage: Int
    
    init(damage: Int) {
        self.name = Strings("offer.buffEveryWeaponDamage.name").local
        self.description = Strings("offer.buffEveryWeaponDamage.description1Param").localWithArgs(damage)
        self.damage = damage
        assert(damage > 0, "Negative or 0 damage not permitted")
    }
    
    func acceptOffer(player: Player) {
        for weapon in player.weapons {
            weapon.adjustDamage(by: self.damage)
        }
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.weapons.isEmpty
    }
    
}
