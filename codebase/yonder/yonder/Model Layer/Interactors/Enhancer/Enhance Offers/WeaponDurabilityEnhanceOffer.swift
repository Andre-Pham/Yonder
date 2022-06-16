//
//  WeaponDurabilityEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponDurabilityEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let amount: Int
    
    init(price: Int, amount: Int) {
        self.price = price
        self.amount = amount
        self.name = Strings.EnhanceOffer.WeaponDurability.Name.local
        self.description = Strings.EnhanceOffer.WeaponDurability.Description1Param.localWithArgs(amount)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustRemainingUses(by: self.amount)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
