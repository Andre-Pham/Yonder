//
//  IncrementEveryPotionCountOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class IncrementEveryPotionCountOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let amount: Int
    
    init(increment: Int) {
        self.name = Strings("incrementEveryPotionCount.name").local
        self.description = Strings("incrementEveryPotionCount.description1Param").localWithArgs(increment)
        self.amount = increment
        assert(increment > 0, "Negative or 0 increment is not permitted")
    }
    
    func acceptOffer(player: Player) {
        for potion in player.potions {
            potion.adjustRemainingUses(by: self.amount)
        }
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.potions.isEmpty
    }
    
}
