//
//  CycleDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 10/1/2024.
//

import Foundation

class CycleDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public let damages: [Int]
    private(set) var damageIndex: Int
    
    init(damagesToCycleThrough: [Int]) {
        self.effectsDescription = Strings("weaponEffectPill.cycleDamage.description1Param").localWithArgs(damagesToCycleThrough.map({ String($0) }).joined(separator: ", "))
        self.damages = damagesToCycleThrough
        self.damageIndex = 0
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damages = Array(original.damages)
        self.damageIndex = original.damageIndex
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case damages
        case damageIndex
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.damages = dataObject.get(Field.damages.rawValue)
        self.damageIndex = dataObject.get(Field.damageIndex.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.damages.rawValue, value: self.damages)
            .add(key: Field.damageIndex.rawValue, value: self.damageIndex)
    }

    // MARK: - Functions
    
    override func onEquip(weapon: Weapon) {
        weapon.setDamage(to: self.damages[self.damageIndex])
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        self.damageIndex = (self.damageIndex + 1)%self.damages.count
        let newDamage = self.damages[self.damageIndex]
        WeaponPillBox.getWeapon(from: self)?.setDamage(to: newDamage)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 0
    }
    
}
