//
//  PricePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class PricePercentBuff: Buff {
    
    private let priceFraction: Double
    
    init(sourceName: String, duration: Int?, priceFraction: Double) {
        self.priceFraction = priceFraction
        
        var effectsDescription: String? = nil
        if self.priceFraction.multiplyingDecreases() {
            effectsDescription = Strings("buff.pricePercent.effectsDescription.outgoingDecrease1Param").localWithArgs(priceFraction.toRelativePercentage())
        } else if self.priceFraction.multiplyingIncreases() {
            effectsDescription = Strings("buff.pricePercent.effectsDescription.outgoingIncrease1Param").localWithArgs(priceFraction.toRelativePercentage())
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .price,
            direction: .outgoing,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.priceFraction = original.priceFraction
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case priceFraction
    }

    required init(dataObject: DataObject) {
        self.priceFraction = dataObject.get(Field.priceFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.priceFraction.rawValue, value: self.priceFraction)
    }

    // MARK: - Functions
    
    override func applyPrice(to gold: Int) -> Int {
        return Int(round(Double(gold)*self.priceFraction))
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            fraction: self.priceFraction,
            stat: Pricing.priceStat,
            timeRemaining: self.timeRemaining
        )
    }
    
}
