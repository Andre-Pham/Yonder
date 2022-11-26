//
//  AccessoryBuffEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 27/11/2022.
//

import Foundation

class AccessoryBuffEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let buff: Buff
    
    init(price: Int, buff: Buff) {
        self.price = price
        self.buff = buff
        self.name = Strings("enhanceOffer.accessoryBuff.name").local
        self.description = Strings("enhanceOffer.accessoryBuff.name").localWithArgs(buff.getEffectsDescription()!)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            accessory.addBuff(buff: self.buff)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
