//
//  WeaponEffectEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponEffectEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let effectPill: WeaponEffectPill
    private(set) var candidateIDs: [UUID]
    
    init(player: Player, price: Int, effectPill: WeaponEffectPill) {
        self.price = price
        self.effectPill = effectPill
        self.name = "Add \(Term.weaponEffect.capitalized) to \(Term.weapon.capitalized)"
        self.description = "Give a \(Term.weapon) <\(effectPill.effectsDescription)>."
        self.candidateIDs = player.weapons.map { $0.id }
    }
    
    func acceptOffer(player: Player, candidateID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == candidateID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.addEffect(self.effectPill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
