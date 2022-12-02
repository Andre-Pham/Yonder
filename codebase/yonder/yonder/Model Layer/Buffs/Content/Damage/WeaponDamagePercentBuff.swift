//
//  WeaponDamagePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponDamagePercentBuff: Buff {
    
    private let damageFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, damageFraction: Double) {
        self.damageFraction = damageFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: damageFraction,
            outgoingIncrease: Strings("buff.weaponDamagePercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponDamagePercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponDamagePercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponDamagePercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponDamagePercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponDamagePercent.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .damage,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.damageFraction = original.damageFraction
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damageFraction
    }

    required init(dataObject: DataObject) {
        self.damageFraction = dataObject.get(Field.damageFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damageFraction.rawValue, value: self.damageFraction)
    }

    // MARK: - Functions
    
    override func applyDamage(to damage: Int, source: Any) -> Int {
        if source is Weapon {
            return Int(round(Double(damage)*self.damageFraction))
        }
        return damage
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            fraction: self.damageFraction,
            defaultTargetsOwner: false,
            target: target,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
