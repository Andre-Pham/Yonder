//
//  ArmorEquipmentPillEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class ArmorEquipmentPillEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let pill: EquipmentPill
    
    init(price: Int, pill: EquipmentPill) {
        self.price = price
        self.pill = pill
        self.name = Strings("enhanceOffer.armorEquipmentPill.name").local
        self.description = Strings("enhanceOffer.armorEquipmentPill.description1Param").localWithArgs(pill.effectsDescription)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.addEquipmentPill(self.pill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
