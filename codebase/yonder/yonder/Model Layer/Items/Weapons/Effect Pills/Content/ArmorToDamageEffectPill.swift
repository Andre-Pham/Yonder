//
//  ArmorToDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 24/11/2022.
//

import Foundation

class ArmorToDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    
    override init() {
        self.effectsDescription = Strings("weaponEffectPill.armorToDamage.description").local
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        guard let weapon = WeaponPillBox.getWeapon(from: self) else {
            assertionFailure("ArmorToDamageEffectPill has no matching weapon")
            return
        }
        let damage = owner.armorPoints
        owner.setArmorPoints(to: 0)
        opposition.delayedDamageValues.addDamageAdjusted(sourceOwner: owner, using: weapon, target: opposition, for: damage)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 50
    }
    
}
