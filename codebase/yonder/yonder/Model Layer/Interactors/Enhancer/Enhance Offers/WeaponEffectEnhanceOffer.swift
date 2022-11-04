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
    
    init(price: Int, effectPill: WeaponEffectPill) {
        self.price = price
        self.effectPill = effectPill
        self.name = Strings("enhanceOffer.weaponEffect.name").local
        self.description = Strings("enhanceOffer.weaponEffect.description1Param").localWithArgs(effectPill.effectsDescription)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.addEffect(self.effectPill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
