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
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", health: Int, goldReward: Int) {
        self.name = name
        self.description = description
        self.health = health
        self.goldReward = goldReward
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldReward)
        player.damageHealth(for: self.health)
    }
    
}
