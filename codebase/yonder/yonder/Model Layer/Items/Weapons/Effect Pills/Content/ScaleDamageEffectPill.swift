//
//  ScaleDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation

class ScaleDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public var previewEffectsDescription: String {
        return self.effectsDescription
    }
    public let damageMultiplier: Double
    
    init(damageMultiplier: Double) {
        if damageMultiplier.multiplyingIncreases() {
            self.effectsDescription = Strings("weaponEffectPill.scaleDamage.increaseDescription1Param").localWithArgs(damageMultiplier.toRelativePercentage())
        } else {
            self.effectsDescription = Strings("weaponEffectPill.scaleDamage.decreaseDescription1Param").localWithArgs(damageMultiplier.toRelativePercentage())
        }
        self.damageMultiplier = damageMultiplier
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damageMultiplier = original.damageMultiplier
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case damageMultiplier
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.damageMultiplier = dataObject.get(Field.damageMultiplier.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.damageMultiplier.rawValue, value: self.damageMultiplier)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            weapon.setDamage(to: (Double(weapon.damage)*self.damageMultiplier).toRoundedInt())
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        let expectedUses = 3 // Magic
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            // If we have the weapon, we can use it to determine the price based on the weapon's existent damage
            return Pricing.playerDamageStat.getValue(
                amount: (Double(weapon.damage).compound(multiply: self.damageMultiplier, index: expectedUses)).toRoundedInt() - weapon.damage
            )
        }
        // Otherwise, we'll just use the base player damage stat
        return Pricing.playerDamageStat.getValue(
            amount: (Double(Pricing.playerDamageStat.baseStatAmount).compound(multiply: self.damageMultiplier, index: expectedUses)).toRoundedInt() - Pricing.playerDamageStat.baseStatAmount
        )
    }
    
}
