//
//  GoldForPriceBuffOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class GoldForPriceBuffOffer: Offer {
    
    public let gold: Int
    public let priceFraction: Double
    
    init(gold: Int, priceFraction: Double) {
        self.gold = gold
        self.priceFraction = priceFraction
        let name: String
        let description: String
        if gold > 0 && priceFraction.multiplyingIncreases() {
            name = Strings("offer.goldForPriceBuff.curse.name").local
            description = Strings("offer.goldForPriceBuff.curse.description2Param").localWithArgs(String(gold), priceFraction.toRelativePercentage())
        } else {
            assert(gold < 0 && priceFraction.multiplyingDecreases(), "Invalid parameters provided for offer")
            name = Strings("offer.goldForPriceBuff.blessing.name").local
            description = Strings("offer.goldForPriceBuff.blessing.description2Param").localWithArgs(String(abs(gold)), priceFraction.toRelativePercentage())
        }
        super.init(name: name, description: description)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case gold
        case priceFraction
    }

    required init(dataObject: DataObject) {
        self.gold = dataObject.get(Field.gold.rawValue)
        self.priceFraction = dataObject.get(Field.priceFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.gold.rawValue, value: self.gold)
            .add(key: Field.priceFraction.rawValue, value: self.priceFraction)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: self.gold)
        let buff = PricePercentBuff(sourceName: self.name, duration: nil, priceFraction: self.priceFraction)
        player.addBuff(buff)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.canAfford(price: self.gold)
    }
    
}
