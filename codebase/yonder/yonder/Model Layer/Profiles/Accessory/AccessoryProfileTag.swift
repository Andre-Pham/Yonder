//
//  AccessoryProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

enum AccessoryProfileTag: CaseIterable {
    
    /// These should be selected as the "primary theme" of the accessory.
    /// For example, if something gives 20% damage resistance, and 10% gold bonus, the primary theme is "defensive".
    /// If it gives +20% damage and lifesteal, the primary theme is "offensive".
    /// If it heals after travelling, the primary theme is "restoration".
    
    /// Applies to defensive accessories that make you feel armored, such as damage resistance or armor gain
    case defensive
    /// Applies to offensive accessories that are focused around damage, such as damage buffs
    case offensive
    /// Applies to accessories that revolve around gold, such as decreased prices
    case gold
    /// Applies to accessories that manipulate health, such as bonus health or healing buffs
    case health
    /// Applies to accessories that do a bit (or a lot) of everything and don't have a strong single theme
    case everything
    
}
