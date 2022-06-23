//
//  WeaponBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that initialises weapon properties, for example providing a healing value.
/// Weapons can only take one of this pill.
protocol WeaponBasePill {
    
    func setup(weapon: Weapon)
    func getValue() -> Int
    
}
