//
//  WeaponArmorPointsRestorationPercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponArmorPointsRestorationPercentBuff: Buff {
    
    private let armorPointsFraction: Double
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsFraction: Double) {
        self.armorPointsFraction = armorPointsFraction
        
        let effectsDescription = BuffEffectsDescription.buildPercentageEffectsDescription(
            direction: direction,
            fraction: armorPointsFraction,
            outgoingIncrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponArmorRestorationPercent.effectsDescription.bidirectionalDecrease1Param"))
        
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: duration,
            type: .armorPoints,
            direction: direction,
            priority: .second)
    }
    
    required init(_ original: BuffAbstract) {
        let original = original as! Self
        self.armorPointsFraction = original.armorPointsFraction
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case armorPointsFraction
    }

    required init(dataObject: DataObject) {
        self.armorPointsFraction = dataObject.get(Field.armorPointsFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.armorPointsFraction.rawValue, value: self.armorPointsFraction)
    }

    // MARK: - Functions
    
    override func applyArmorPoints(to armorPoints: Int, source: Any) -> Int {
        if source is Weapon {
            return Int(round(Double(armorPoints)*self.armorPointsFraction))
        }
        return armorPoints
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getTargetedBuffValue(
            fraction: self.armorPointsFraction,
            defaultTargetsOwner: true,
            target: target,
            playerStat: Pricing.playerArmorPointsRestorationStat,
            foeStat: Pricing.foeArmorPointsRestorationStat,
            timeRemaining: self.timeRemaining,
            direction: self.direction
        )
    }
    
}
