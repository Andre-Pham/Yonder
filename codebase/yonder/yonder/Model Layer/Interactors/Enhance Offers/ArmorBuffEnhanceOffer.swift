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
    private let buff: BuffAbstract
    private(set) var candidateIDs: [UUID]
    
    init(player: Player, price: Int, buff: BuffAbstract) {
        self.price = price
        self.buff = buff
        self.name = "Add \(Term.buffOrEffect.capitalized) to \(Term.armor.capitalized)"
        self.description = "Give some \(Term.armor) <\(buff.effectsDescription ?? "nothing")>."
        self.candidateIDs = player.allArmorPieces.map { $0.id }
    }
    
    func acceptOffer(player: Player, candidateID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == candidateID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.addBuff(buff: self.buff)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
