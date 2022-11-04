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
        self.name = Strings("offer.freeGold.name").local
        self.description = Strings("offer.freeGold.description1Param").localWithArgs(goldAmount)
        self.goldAmount = goldAmount
    }
    
    static func build(stage: Int) -> Offer {
        let amount = Int(Double(Int.random(in: 2...10)*50)*(1 + Double(stage)/10))
        return FreeGoldOffer(goldAmount: amount)
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldAmount)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
