//
//  ArmorPointsEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class ArmorPointsEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let armorPoints: Int
    
    init(price: Int, armorPoints: Int) {
        self.price = price
        self.armorPoints = armorPoints
        self.name = Strings("enhanceOffer.armorPoints.name").local
        self.description = Strings("enhanceOffer.armorPoints.description1Param").localWithArgs(armorPoints)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            player.enhanceArmorPoints(of: armor, armorPoints: self.armorPoints)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
