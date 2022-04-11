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
        self.name = "Upgrade \(Term.armor.capitalized) \(Term.armorPoints.capitalized)"
        self.description = "Increase some \(Term.armor)'s \(Term.armorPoints) by \(armorPoints)."
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.adjustArmorPoints(by: self.armorPoints)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
