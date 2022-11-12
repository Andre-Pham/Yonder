//
//  MaxHealthForArmorPointsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class MaxHealthForArmorPointsOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    init() {
        self.name = Strings("offer.maxHealthForArmorPoints.name").local
        self.description = Strings("offer.maxHealthForArmorPoints.description").local
    }
    
    func acceptOffer(player: Player) {
        for armorPiece in player.allArmorPieces {
            let amount = armorPiece.armorPoints
            armorPiece.adjustArmorPoints(by: amount)
            player.restoreArmorPoints(for: amount)
        }
        player.adjustMaxHealth(by: -(Double(player.maxHealth)/2.0).toRoundedInt())
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.armorPoints > 0
    }
    
}
