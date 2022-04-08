//
//  WeaponDamageEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponDamageEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let damage: Int
    private(set) var candidateIDs: [UUID]
    
    init(player: Player, price: Int, damage: Int) {
        self.price = price
        self.damage = damage
        self.name = "Upgrade \(Term.weapon.capitalized) \(Term.damage.capitalized)"
        self.description = "Increase a \(Term.weapon)'s \(Term.damage) by \(damage)."
        self.candidateIDs = player.weapons.map { $0.id }
    }
    
    func acceptOffer(player: Player, candidateID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == candidateID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustDamage(by: self.damage)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
