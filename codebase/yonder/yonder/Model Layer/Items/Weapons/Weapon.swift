//
//  Weapon.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Weapon: ItemAbstract, Usable, Purchasable {
    
    private(set) var basePurchasePrice: Int = 0
    private let basePill: WeaponBasePill
    private let durabilityPill: WeaponDurabilityPill
    private(set) var effectPills: [WeaponEffectPill]
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", basePill: WeaponBasePill, durabilityPill: WeaponDurabilityPill, effectPills: [WeaponEffectPill] = []) {
        self.basePill = basePill
        self.durabilityPill = durabilityPill
        self.effectPills = effectPills
        
        super.init(name: name, description: description)
        
        self.basePurchasePrice = self.getCurrentPrice()
        self.basePill.setup(weapon: self)
    }
    
    func getCurrentPrice() -> Int {
        return self.remainingUses*(
            self.basePill.getValue() +
            self.durabilityPill.getValue() +
            self.effectPills.map { $0.getValue() }.reduce(0, +))
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        if self.healthRestoration > 0 {
            owner.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        }
        if self.damage > 0 {
            opposition.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        }
        
        for pill in self.effectPills {
            pill.apply(owner: owner, opposition: opposition)
        }
        
        // Durability pill comes after, otherwise stuff like dulling pill wouldn't work as intended
        self.durabilityPill.use(on: self)
    }
    
}

class BaseAttack: Weapon {
    
    init(damage: Int) {
        super.init(basePill: DamageBasePill(damage: damage, durability: 1), durabilityPill: InfiniteDurabilityPill())
    }
    
}
