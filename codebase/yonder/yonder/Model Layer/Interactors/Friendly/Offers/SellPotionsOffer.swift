//
//  SellPotionsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class SellPotionsOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    init() {
        self.name = Strings("offer.sellPotions.name").local
        self.description = Strings("offer.sellPotions.description").local
    }
    
    func acceptOffer(player: Player) {
        let fairValue = player.potions.map({ $0.getBasePurchasePrice() }).reduce(0, +)
        player.modifyGoldAdjusted(by: 3*fairValue)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.potions.isEmpty
    }
    
}
