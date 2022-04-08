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
    private(set) var candidateIDs: [UUID]
    
    init(player: Player, price: Int, armorPoints: Int) {
        self.price = price
        self.armorPoints = armorPoints
        self.name = "Upgrade \(Term.armor.capitalized) \(Term.armorPoints.capitalized)"
        self.description = "Increase some \(Term.armor)'s \(Term.armorPoints) by \(armorPoints)."
        self.candidateIDs = player.allArmorPieces.map { $0.id }
    }
    
    func acceptOffer(player: Player, candidateID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == candidateID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.adjustArmorPoints(by: self.armorPoints)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
