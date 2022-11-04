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
    
    init(price: Int, damage: Int) {
        self.price = price
        self.damage = damage
        self.name = Strings("enhanceOffer.weaponDamage.name").local
        self.description = Strings("enhanceOffer.weaponDamage.description1Param").localWithArgs(damage)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustDamage(by: self.damage)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
