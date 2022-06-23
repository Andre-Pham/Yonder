//
//  InfiniteDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class InfiniteDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String = Strings.WeaponDurabilityPill.Infinite.Description.local
    
    func use(on weapon: Weapon) {
        // Do nothing - weapon has infinite durability
    }

    func getValue() -> Int {
        return 500
    }
    
}
