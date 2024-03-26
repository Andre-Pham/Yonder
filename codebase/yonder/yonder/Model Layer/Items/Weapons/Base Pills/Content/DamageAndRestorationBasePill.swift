//
//  DamageAndRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/11/2022.
//

import Foundation

class DamageAndRestorationBasePill: WeaponBasePill {
    
    public let damage: Int
    public let restoration: Int
    public let effectsDescription: String? = nil
    public let previewEffectsDescription: String? = nil
    
    init(damage: Int, restoration: Int) {
        self.damage = damage
        self.restoration = restoration
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        self.restoration = original.restoration
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damage
        case restoration
    }

    required init(dataObject: DataObject) {
        self.damage = dataObject.get(Field.damage.rawValue)
        self.restoration = dataObject.get(Field.restoration.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damage.rawValue, value: self.damage)
            .add(key: Field.restoration.rawValue, value: self.restoration)
    }

    // MARK: - Functions
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
        weapon.setRestoration(to: self.restoration)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damage) + Pricing.playerHealthRestorationStat.getValue(amount: self.restoration)
    }
    
}
