//
//  GoldForPriceBuffOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class GoldForPriceBuffOffer: Offer {
    
    public let name: String
    public let description: String
    public let id: UUID = UUID()
    
    public let gold: Int
    public let priceFraction: Double
    
    init(gold: Int, priceFraction: Double) {
        self.gold = gold
        self.priceFraction = priceFraction
        if gold > 0 && priceFraction.multiplyingIncreases() {
            self.name = Strings("offer.goldForPriceBuff.curse.description").local
            self.description = Strings("offer.goldForPriceBuff.curse.description2Param").localWithArgs(String(gold), priceFraction.toRelativePercentage())
        }
        assert(gold < 0 && priceFraction.multiplyingDecreases(), "Invalid parameters provided for offer")
        self.name = Strings("offer.goldForPriceBuff.blessing.description").local
        self.description = Strings("offer.goldForPriceBuff.blessing.description2Param").localWithArgs(String(abs(gold)), priceFraction.toRelativePercentage())
    }
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.gold)
        let buff = PricePercentBuff(sourceName: self.name, duration: nil, priceFraction: self.priceFraction)
        player.addBuff(buff)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.canAfford(price: self.gold)
    }
    
}
