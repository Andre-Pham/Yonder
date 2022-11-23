//
//  WeaponProfileTag.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

enum WeaponProfileTag {
    
    case damage
    case damageAndRestoration
    case restoration
    case healthRestoration
    case armorPointsRestoration
    case collateral // E.g. converts health into shields, self damaging, and burning effects
    case consumesFoe // E.g. taking or copying their attack, or lifesteal
    
}
