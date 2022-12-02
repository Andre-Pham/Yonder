//
//  DamageBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DamageBasePill: WeaponBasePill {
    
    private(set) var damage: Int
    public let effectsDescription: String? = nil
    
    init(damage: Int) {
        self.damage = damage
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damage
    }

    required init(dataObject: DataObject) {
        self.damage = dataObject.get(Field.damage.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damage.rawValue, value: self.damage)
    }

    // MARK: - Functions
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage)
    }
    
}
