//
//  WeaponProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

enum WeaponProfileTag: String {
    
    // NOTE TO SELF
    // I don't need to create a tag for every aspect of weapons, e.g. no need to worry about durability
    // The only tags I need to concern myself with is the ones that dictate the name
    // e.g. if a weapon is called "healing staff", it needs to heal, but it doesn't matter if it has
    // 1 or infinite durability
    
    case damage = "damage"
    case restoration = "restoration"
    case healthRestoration = "healthRestoration"
    
}
