//
//  DamageRestorationSwapEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

class DamageRestorationSwapEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    
    override init() {
        self.effectsDescription = Strings("weaponEffectPill.damageRestorationSwap.description").local
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
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            let weaponDamage = weapon.damage
            let weaponRestoration = weapon.restoration
            weapon.setDamage(to: weaponRestoration)
            weapon.setRestoration(to: weaponDamage)
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 0
    }
    
}
