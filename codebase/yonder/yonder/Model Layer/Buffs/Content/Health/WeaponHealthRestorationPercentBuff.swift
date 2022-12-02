//
//  WeaponHealthRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponHealthRestorationPercentBuff: Buff {
    
    private let healthFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, healthFraction: Double) {
        self.healthFraction = healthFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: healthFraction,
            outgoingIncrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponHealthRestorationPercent.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .health,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.healthFraction = original.healthFraction
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthFraction
    }

    required init(dataObject: DataObject) {
        self.healthFraction = dataObject.get(Field.healthFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthFraction.rawValue, value: self.healthFraction)
    }

    // MARK: - Functions
    
    override func applyHealth(to health: Int, source: Any) -> Int {
        if source is Weapon {
            return Int(round(Double(health)*self.healthFraction))
        }
        return health
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            fraction: self.healthFraction,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerHealthRestorationStat,
            foeStat: Pricing.foeHealthRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
