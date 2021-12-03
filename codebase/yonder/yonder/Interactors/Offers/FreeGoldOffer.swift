//
//  GoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class FreeGoldOffer: Offer {
    
    public let id: UUID = UUID()
    public let goldAmount: Int
    
    init(goldAmount: Int) {
        self.goldAmount = goldAmount
    }
    
    func acceptOffer(player: Player) {
        let adjustedGold = BuffApps.getAdjustedGoldWithBonus(reciever: player, gold: self.goldAmount)
        player.adjustGold(by: adjustedGold)
    }
    
}
