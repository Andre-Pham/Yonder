//
//  WeaponPillProtocols.swift
//  yonder
//
//  Created by Andre Pham on 11/2/2022.
//

import Foundation

/// Pill that initialises weapon properties, for example providing a healing value.
/// Weapons can only take one of this pill.
protocol WeaponBasePill {
    
    var type: WeaponType { get }
    
    func setup(weapon: Weapon)
    func getValue() -> Int
    
}

/// Pill that sets how the weapon loses remaining uses (i.e. durability) over time.
/// Weapons can only take one of this pill.
protocol WeaponDurabilityPill {
    
    func use(on weapon: Weapon)
    func getValue() -> Int
    
}

/// Pill that provides the weapon with additional effects, such as providing buffs.
protocol WeaponEffectPill {
    
    var priority: WeaponEffectPillPriority { get }
    
    func apply(owner: ActorAbstract, target: ActorAbstract)
    func getValue() -> Int
    
}

enum WeaponEffectPillPriority: Int {
    case first = 0
    case second = 1
}
