//
//  PermanentDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation

class PermanentDamageEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public var previewEffectsDescription: String {
        return self.effectsDescription
    }
    
    override init() {
        self.effectsDescription = Strings("weaponEffectPill.permanentDamage.description").local
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
            assertionFailure("PermanentDamageEffectPill has no matching weapon")
            return
        }
        let damageDealt = owner.getIndicativeDamage(of: weapon, opposition: opposition)
        let damageDealtToHealth = max(0, damageDealt - opposition.armorPoints)
        // We can't just set the opposition's max health lower - they'll take the (delayed) damage after, meaning they effectively take double damage
        // Hence we also make the permanent damage delayed
        // We don't apply buffs and adjustments to the damage since we're already taking those into account when retrieving the indicative damage
        if damageDealtToHealth > 0 {
            opposition.delayedDamageValues.addDamage(damage: damageDealtToHealth, type: .maxHealth)
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        assertionFailure("PermanentDamageEffectPill is being used on a non-player, and only players should be capable of using this effect")
        return 0
    }
    
}
