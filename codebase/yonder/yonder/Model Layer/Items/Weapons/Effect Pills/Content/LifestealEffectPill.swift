//
//  LifestealEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 4/11/2022.
//

import Foundation

class LifestealEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    private let lifestealFraction: Double
    
    init(lifestealFraction: Double) {
        self.effectsDescription = Strings("weaponEffectPill.lifesteal.description1Param").localWithArgs((lifestealFraction*100.0).toString())
        self.lifestealFraction = lifestealFraction
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.lifestealFraction = original.lifestealFraction
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case lifestealFraction
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.lifestealFraction = dataObject.get(Field.lifestealFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.lifestealFraction.rawValue, value: self.lifestealFraction)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        guard let weapon = WeaponPillBox.getWeapon(from: self) else {
            assertionFailure("LifestealEffectPill has no matching weapon")
            return
        }
        let damageDealt = owner.getIndicativeDamage(of: weapon, opposition: opposition)
        let healthToRestore = (Double(damageDealt)*self.lifestealFraction).toRoundedInt()
        owner.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: owner, using: weapon, for: healthToRestore)
    }
    
    func calculateBasePurchasePrice() -> Int {
        Pricing.playerHealthRestorationStat.getValue(
            amount: Pricing.playerDamageStat.fractionOfBaseStatAmount(self.lifestealFraction)
        )
    }
    
}
