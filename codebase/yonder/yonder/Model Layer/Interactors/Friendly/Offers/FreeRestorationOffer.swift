//
//  FreeRestorationOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeRestorationOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let restorationAmount: Int
    
    init(restorationAmount: Int) {
        self.name = Strings("offer.freeRestoration.name").local
        self.description = Strings("offer.freeRestoration.description1Param").localWithArgs(restorationAmount)
        self.restorationAmount = restorationAmount
    }
    
    func acceptOffer(player: Player) {
        player.restoreAdjusted(sourceOwner: NoActor(), using: self, for: self.restorationAmount)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !(player.isFullHealth && player.isFullArmorPoints)
    }
    
}
