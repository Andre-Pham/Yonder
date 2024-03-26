//
//  DecrementDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DecrementDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String?
    public let previewEffectsDescription: String? = nil
    public let decrementation: Int
    private let durability: Int
    
    init(durability: Int, decrementBy amount: Int = 1) {
        self.durability = durability
        self.effectsDescription = Strings("weaponDurabilityPill.decrement.description1Param").localWithArgs(amount)
        self.decrementation = -amount
        super.init()
    }
    
    required init(_ original: WeaponDurabilityPillAbstract) {
        let original = original as! Self
        self.durability = original.durability
        self.effectsDescription = original.effectsDescription
        self.decrementation = original.decrementation
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case durability
        case effectsDescription
        case decrementation
    }

    required init(dataObject: DataObject) {
        self.durability = dataObject.get(Field.durability.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.decrementation = dataObject.get(Field.decrementation.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.durability.rawValue, value: self.durability)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.decrementation.rawValue, value: self.decrementation)
    }

    // MARK: - Functions
    
    func setupDurability(weapon: Weapon) {
        weapon.setRemainingUses(to: self.durability)
        weapon.setInfiniteRemainingUses(to: false)
    }
    
    func use(on weapon: Weapon) {
        weapon.adjustRemainingUses(by: self.decrementation)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 0
    }
    
}
