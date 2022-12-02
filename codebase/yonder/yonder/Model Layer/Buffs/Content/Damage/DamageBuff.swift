//
//  DamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class DamageBuff: Buff {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings("buff.damage.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.damage.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.damage.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.damage.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.damage.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.damage.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .damage,
            direction: direction,
            priority: .first)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.damageDifference = original.damageDifference
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damageDifference
    }

    required init(dataObject: DataObject) {
        self.damageDifference = dataObject.get(Field.damageDifference.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damageDifference.rawValue, value: self.damageDifference)
    }

    // MARK: - Functions
    
    override func applyDamage(to damage: Int, source: Any) -> Int {
        return self.damageDifference + damage
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            amount: self.damageDifference,
            defaultTargetsOwner: false,
            target: target,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
