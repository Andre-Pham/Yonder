//
//  WeaponProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

enum WeaponProfileTag {
    
    /// The weapon deals damage
    case damage
    /// The weapon deals damage and restores health
    case damageAndRestoration
    /// The weapon heals you, first restoring health, then any excess heals armor points
    case restoration
    /// The weapon heals your health
    case healthRestoration
    /// The weapon heals your armor points
    case armorPointsRestoration
    /// The weapon has some "chaotic" effect that often (but not necessarily) damages you, such as weapons that damage both you and the opponent, weapons that convert your own health into shields, weapons that have burning effects, etc
    case collateral
    /// The weapon has some "stealing" effect such as taking or copying the opponent's attack, or weapons that restore a portion of damage dealt as health
    case consumesFoe
    
}
