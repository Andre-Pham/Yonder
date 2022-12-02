//
//  GrowDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

class GrowDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public let damageIncrease: Int
    
    init(damageIncrease: Int) {
        self.effectsDescription = Strings("weaponEffectPill.growDamage.description1Param").localWithArgs(damageIncrease)
        self.damageIncrease = damageIncrease
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damageIncrease = original.damageIncrease
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case damageIncrease
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.damageIncrease = dataObject.get(Field.damageIncrease.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.damageIncrease.rawValue, value: self.damageIncrease)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        WeaponPillBox.getWeapon(from: self)?.adjustDamage(by: self.damageIncrease)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damageIncrease)
    }
    
}
