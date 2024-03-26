//
//  DullingDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DullingDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String?
    public var previewEffectsDescription: String? {
        return self.effectsDescription
    }
    public let damageLostPerUse: Int
    
    init(damageLostPerUse: Int) {
        self.effectsDescription = Strings("weaponDurabilityPill.dulling.description1Param").localWithArgs(damageLostPerUse)
        self.damageLostPerUse = damageLostPerUse
        super.init()
    }
    
    required init(_ original: WeaponDurabilityPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damageLostPerUse = original.damageLostPerUse
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case damageLostPerUse
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.damageLostPerUse = dataObject.get(Field.damageLostPerUse.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.damageLostPerUse.rawValue, value: self.damageLostPerUse)
    }

    // MARK: - Functions
    
    func setupDurability(weapon: Weapon) {
        weapon.setRemainingUses(to: 1)
        weapon.setInfiniteRemainingUses(to: true)
    }
    
    func use(on weapon: Weapon) {
        weapon.adjustDamage(by: -self.damageLostPerUse)
        if weapon.damage <= 0 {
            weapon.setRemainingUses(to: 0)
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 0
    }
    
}
