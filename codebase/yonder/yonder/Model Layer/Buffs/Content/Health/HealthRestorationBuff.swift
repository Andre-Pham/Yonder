//
//  HealthRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 20/9/2022.
//

import Foundation

class HealthRestorationBuff: Buff {
    
    private let healthDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthDifference: Int) {
        self.healthDifference = healthDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: healthDifference,
            outgoingIncrease: Strings("buff.healthRestoration.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.healthRestoration.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.healthRestoration.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.healthRestoration.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.healthRestoration.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.healthRestoration.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .health,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.healthDifference = original.healthDifference
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthDifference
    }

    required init(dataObject: DataObject) {
        self.healthDifference = dataObject.get(Field.healthDifference.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthDifference.rawValue, value: self.healthDifference)
    }

    // MARK: - Functions
    
    override func applyHealth(to health: Int, source: Any) -> Int {
        return self.healthDifference + health
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.healthDifference,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerHealthRestorationStat,
            foeStat: Pricing.foeHealthRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
