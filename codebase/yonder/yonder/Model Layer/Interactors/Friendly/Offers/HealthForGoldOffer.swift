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
        self.name = Strings.Offer.HealthForGold.Name.local
        self.description = Strings.Offer.HealthForGold.Description2Param.localWithArgs(health, goldReward)
        self.health = health
        self.goldReward = goldReward
    }
    
    static func build(stage: Int) -> Offer {
        let health = Int(Double(Int.random(in: 1...7)*50))
        let goldReward = Int(round(Double(health)*(1.0 + Double.random(in: 0...1)))).nearest(10)
        return HealthForGoldOffer(health: health, goldReward: goldReward)
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
