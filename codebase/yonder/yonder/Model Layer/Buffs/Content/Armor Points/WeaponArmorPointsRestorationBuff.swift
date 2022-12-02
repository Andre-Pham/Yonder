//
//  WeaponArmorPointsRestorationBuff.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation

class WeaponArmorPointsRestorationBuff: Buff {
    
    private let armorPointsDifference: Int
    
    init(sourceName: String, direction: BuffDirection, duration: Int?, armorPointsDifference: Int) {
        self.armorPointsDifference = armorPointsDifference
        
        let effectsDescription = BuffEffectsDescription.buildMagnitudeEffectsDescription(
            direction: direction,
            difference: armorPointsDifference,
            outgoingIncrease: Strings("buff.weaponArmorRestoration.effectsDescription.outgoingIncrease1Param"),
            outgoingDecrease: Strings("buff.weaponArmorRestoration.effectsDescription.outgoingDecrease1Param"),
            incomingIncrease: Strings("buff.weaponArmorRestoration.effectsDescription.incomingIncrease1Param"),
            incomingDecrease: Strings("buff.weaponArmorRestoration.effectsDescription.incomingDecrease1Param"),
            bidirectionalIncrease: Strings("buff.weaponArmorRestoration.effectsDescription.bidirectionalIncrease1Param"),
            bidirectionalDecrease: Strings("buff.weaponArmorRestoration.effectsDescription.bidirectionalDecrease1Param"))
        
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
        if source is Weapon {
            return self.armorPointsDifference + armorPoints
        }
        return armorPoints
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
