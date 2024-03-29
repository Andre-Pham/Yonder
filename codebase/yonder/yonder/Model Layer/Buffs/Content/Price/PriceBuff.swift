//
//  PriceBuff.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class PriceBuff: Buff {
    
    private let priceDifference: Int
    
    init(sourceName: String, duration: Int?, priceDifference: Int) {
        self.priceDifference = priceDifference
        
        var effectsDescription: String? = nil
        if self.priceDifference < 0 {
            effectsDescription = Strings("buff.price.effectsDescription.outgoingDecrease2Param").localWithArgs(
                Strings("currencySymbol").local,
                String(abs(self.priceDifference))
            )
        } else if self.priceDifference > 0 {
            effectsDescription = Strings("buff.price.effectsDescription.outgoingIncrease2Param").localWithArgs(
                Strings("currencySymbol").local,
                String(self.priceDifference)
            )
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .price,
            direction: .outgoing,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.priceDifference = original.priceDifference
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case priceDifference
    }

    required init(dataObject: DataObject) {
        self.priceDifference = dataObject.get(Field.priceDifference.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.priceDifference.rawValue, value: self.priceDifference)
    }

    // MARK: - Functions
    
    override func applyPrice(to gold: Int) -> Int {
        return self.priceDifference + gold
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            amount: self.priceDifference,
            stat: Pricing.priceStat,
            timeRemaining: self.timeRemaining
        )
    }
    
}
