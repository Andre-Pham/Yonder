//
//  BaseAttack.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class BaseAttack: Weapon {
    
    init(damage: Int) {
        super.init(basePill: DamageBasePill(damage: damage), durabilityPill: InfiniteDurabilityPill())
    }
    
    required init(_ original: Weapon) {
        super.init(basePill: DamageBasePill(damage: original.damage), durabilityPill: InfiniteDurabilityPill())
    }
    
}
