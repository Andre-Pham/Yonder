//
//  SelfDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 24/11/2022.
//

import Foundation

class SelfDamageEffectPill: WeaponEffectPill {
    
    public let damage: Int
    public let effectsDescription: String
    
    init(damage: Int) {
        self.damage = damage
        self.effectsDescription = Strings("weaponEffectPill.selfDamage.description1Param").localWithArgs(damage)
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damage
        case effectsDescription
    }

    required init(dataObject: DataObject) {
        self.damage = dataObject.get(Field.damage.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damage.rawValue, value: self.damage)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        guard let weapon = WeaponPillBox.getWeapon(from: self) else {
            assertionFailure("SelfDamageEffectPill has no matching weapon")
            return
        }
        owner.delayedDamageValues.addDamageAdjusted(sourceOwner: owner, using: weapon, target: owner, for: self.damage)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return -Pricing.playerArmorPointsRestorationStat.getValue(amount: self.damage)
    }
    
}
