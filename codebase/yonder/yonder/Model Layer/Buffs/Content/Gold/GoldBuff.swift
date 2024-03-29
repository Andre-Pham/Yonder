//
//  GoldBuff.swift
//  yonder
//
//  Created by Andre Pham on 26/9/2022.
//

import Foundation

class GoldBuff: Buff {
    
    private let goldDifference: Int
    
    init(sourceName: String, duration: Int?, goldDifference: Int) {
        self.goldDifference = goldDifference
        
        var effectsDescription: String? = nil
        if self.goldDifference < 0 {
            effectsDescription = Strings("buff.gold.effectsDescription.incomingDecrease2Param").localWithArgs(
                Strings("currencySymbol").local,
                String(self.goldDifference)
            )
        } else if self.goldDifference > 0 {
            effectsDescription = Strings("buff.gold.effectsDescription.incomingIncrease2Param").localWithArgs(
                Strings("currencySymbol").local,
                String(self.goldDifference)
            )
        }
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .goldBonus,
            direction: .incoming,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.goldDifference = original.goldDifference
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case goldDifference
    }

    required init(dataObject: DataObject) {
        self.goldDifference = dataObject.get(Field.goldDifference.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.goldDifference.rawValue, value: self.goldDifference)
    }

    // MARK: - Functions
    
    override func applyGoldBonus(to gold: Int) -> Int {
        return self.goldDifference + gold
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            amount: self.goldDifference,
            stat: Pricing.receivedGoldStat,
            timeRemaining: self.timeRemaining
        )
    }
    
}
