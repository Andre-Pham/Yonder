//
//  ArmorPointsRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 20/9/2022.
//

import Foundation

class ArmorPointsRestorationBuff: Buff {
    
    private let armorPointsDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsDifference: Int) {
        self.armorPointsDifference = armorPointsDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: armorPointsDifference,
            outgoingIncrease: Strings("buff.armorRestoration.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.armorRestoration.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.armorRestoration.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.armorRestoration.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.armorRestoration.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.armorRestoration.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .armorPoints,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.armorPointsDifference = original.armorPointsDifference
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case armorPointsDifference
    }

    required init(dataObject: DataObject) {
        self.armorPointsDifference = dataObject.get(Field.armorPointsDifference.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.armorPointsDifference.rawValue, value: self.armorPointsDifference)
    }

    // MARK: - Functions
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int {
        return self.armorPointsDifference + armorPoints
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.armorPointsDifference,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerArmorPointsRestorationStat,
            foeStat: Pricing.foeArmorPointsRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
