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
