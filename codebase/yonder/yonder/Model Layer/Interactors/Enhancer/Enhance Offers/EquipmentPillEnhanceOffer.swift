//
//  EquipmentPillEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class EquipmentPillEnhanceOffer: EnhanceOffer {
    
    public let id: UUID = UUID()
    public let price: Int
    public let name: String
    public let description: String
    private let pill: EquipmentPill
    
    init(price: Int, pill: EquipmentPill) {
        self.price = price
        self.pill = pill
        self.name = Strings("enhanceOffer.equipmentPill.name").local
        self.description = Strings("enhanceOffer.equipmentPill.description1Param").localWithArgs(pill.effectsDescription)
    }
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces + player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        guard self.canBePurchased(price: self.price, purchaser: player) else {
            return
        }
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }) {
            armor.addEquipmentPill(self.pill)
            player.modifyGoldAdjusted(by: -self.price)
        } else if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }) {
            accessory.addEquipmentPill(self.pill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
