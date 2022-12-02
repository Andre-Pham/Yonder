//
//  WeaponDamageBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponDamageBuff: Buff {
    
    private let damageDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageDifference: Int) {
        self.damageDifference = damageDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: damageDifference,
            outgoingIncrease: Strings("buff.weaponDamage.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponDamage.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponDamage.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponDamage.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponDamage.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponDamage.effectsDescription.bidirectionalDecrease1Param"))
        
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
        if source is Weapon {
            return self.damageDifference + damage
        }
        return damage
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
