//
//  ArmorBuffEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class ArmorBuffEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let buff: Buff
    
    init(price: Int, buff: Buff) {
        self.price = price
        self.buff = buff
        self.name = Strings("enhanceOffer.armorBuff.name").local
        self.description = Strings("enhanceOffer.armorBuff.description1Param").localWithArgs(buff.getEffectsDescription()!)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.addBuff(buff: self.buff)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
