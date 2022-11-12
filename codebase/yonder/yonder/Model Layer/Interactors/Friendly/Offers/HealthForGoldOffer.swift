//
//  HealthForGoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import Foundation

class HealthForGoldOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let health: Int
    public let goldReward: Int
    
    init(health: Int, goldReward: Int) {
        self.name = Strings("offer.healthForGold.name").local
        self.description = Strings("offer.healthForGold.description2Param").localWithArgs(health, goldReward)
        self.health = health
        self.goldReward = goldReward
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldReward)
        player.damageHealth(for: self.health)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        // If the player wants to, let them
        // Provides opportunities for phoenix abilities too
        return true
    }
    
}
