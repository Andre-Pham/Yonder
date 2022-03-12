//
//  GoldOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class FreeGoldOffer: Offer {
    
    public let name: String
    public let description: String
    
    public let id: UUID = UUID()
    public let goldAmount: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", goldAmount: Int) {
        self.name = name
        self.description = description
        self.goldAmount = goldAmount
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.goldAmount)
    }
    
}
