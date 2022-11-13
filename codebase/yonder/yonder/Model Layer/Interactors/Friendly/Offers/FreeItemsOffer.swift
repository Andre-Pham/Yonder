//
//  FreeItemsOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeItemsOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let potions: [Potion]
    public let consumables: [Consumable]
    
    init(potions: [Potion], consumables: [Consumable]) {
        let names = (potions.map({ Strings("dotPoint").local.continuedBy($0.name) }) +
                     consumables.map({ Strings("dotPoint").local.continuedBy($0.name) }))
        let namesDescription = names.joined(separator: "\n")
        self.name = Strings("offer.freeItems.name").local
        self.description = Strings("offer.freeItems.description1Param").localWithArgs(namesDescription)
        self.potions = potions
        self.consumables = consumables
    }
    
    func acceptOffer(player: Player) {
        self.potions.forEach({ player.addPotion($0) })
        self.consumables.forEach({ player.addConsumable($0) })
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.potions.isEmpty
    }
    
}
