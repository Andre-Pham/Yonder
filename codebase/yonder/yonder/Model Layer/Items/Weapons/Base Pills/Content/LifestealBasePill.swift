//
//  LifestealBasePill.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LifestealBasePill: WeaponBasePill, DamageSubscriber, HealthRestorationSubscriber {
    
    private(set) var damage: Int
    public let effectsDescription: String?
    
    init(damage: Int) {
        self.damage = damage
        self.effectsDescription = Strings.WeaponBasePill.Lifesteal.EffectsDescription.local
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.damage = original.damage
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    func setup(weapon: Weapon) {
        weapon.setDamage(to: self.damage)
        weapon.setHealthRestoration(to: self.damage)
        weapon.addDamageSubscriber(self)
        weapon.addHealthRestorationSubscriber(self)
    }
    
    func getValue() -> Int {
        return self.damage*3/2
    }
    
    func onDamageChange(_ item: Item, old: Int) {
        item.setHealthRestoration(to: item.damage)
    }
    
    func onHealthRestorationChange(_ item: Item, old: Int) {
        if item.healthRestoration != item.damage {
            item.setHealthRestoration(to: item.damage)
        }
    }
    
}
