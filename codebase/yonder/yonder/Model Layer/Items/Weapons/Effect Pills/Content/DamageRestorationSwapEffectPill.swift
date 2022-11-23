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
