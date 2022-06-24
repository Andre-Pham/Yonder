//
//  GoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class FreeGoldOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let goldAmount: Int
    
    init(goldAmount: Int) {
        self.name = Strings.Offer.FreeGold.Name.local
        self.description = Strings.Offer.FreeGold.Description1Param.localWithArgs(goldAmount)
        self.goldAmount = goldAmount
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldAmount)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
