//
//  DefaultPlayerWeapon.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class DefaultPlayerWeapon: Weapon {
    
    init() {
        super.init(name: Strings("weapon.defaultPlayerWeapon.name").local, description: Strings("weapon.defaultPlayerWeapon.description").local, basePill: DamageBasePill(damage: 25), durabilityPill: InfiniteDurabilityPill())
    }
    
    required init(_ original: Weapon) {
        super.init(basePill: DamageBasePill(damage: original.damage), durabilityPill: InfiniteDurabilityPill())
    }
    
}
