//
//  WeaponEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that provides the weapon with additional effects, such as providing buffs.
protocol WeaponEffectPill {
    
    var effectsDescription: String { get }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract)
    func getValue() -> Int
    
}
