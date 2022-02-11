//
//  Weapon.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Weapon: ItemAbstract, Usable, Purchasable {
    
    private(set) var basePurchasePrice: Int = 0
    public let type: WeaponType
    private let basePill: WeaponBasePill
    private let durabilityPill: WeaponDurabilityPill
    private(set) var effectPills: [WeaponEffectPill]
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", basePill: WeaponBasePill, durabilityPill: WeaponDurabilityPill, effectPills: [WeaponEffectPill] = []) {
        self.basePill = basePill
        self.type = basePill.type
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
    
    func use(owner: ActorAbstract, target: ActorAbstract) {
        switch self.type {
        case .damage:
            target.damageAdjusted(sourceOwner: owner, using: self, for: self.damage)
        case .healthRestoration:
            target.restoreHealthAdjusted(sourceOwner: owner, using: self, for: self.healthRestoration)
        case .effect:
            break
        }
        
        for pill in self.effectPills {
            pill.apply(owner: owner, target: target)
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

enum WeaponType {
    case damage
    case healthRestoration
    case effect // Provides effect(s) without inflicting healing or damage
}
