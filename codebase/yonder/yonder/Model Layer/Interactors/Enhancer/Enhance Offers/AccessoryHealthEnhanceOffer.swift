//
//  AccessoryHealthEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class AccessoryHealthEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let health: Int
    
    init(price: Int, health: Int) {
        self.price = price
        self.health = health
        self.name = Strings("enhanceOffer.accessoryHealth.name").local
        self.description = Strings("enhanceOffer.accessoryHealth.description1Param").localWithArgs(health)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            accessory.adjustHealthBonus(by: self.health)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
