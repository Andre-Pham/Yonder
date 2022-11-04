//
//  InfiniteDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class InfiniteDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String = Strings("weaponDurabilityPill.infinite.description").local
    
    override init() {
        // This is required to provide an empty initialiser
        super.init()
    }
    
    required init(_ original: WeaponDurabilityPillAbstract) {
        super.init(original)
    }
    
    func setupDurability(weapon: Weapon) {
        weapon.setRemainingUses(to: 1)
        weapon.setInfiniteRemainingUses(to: true)
    }
    
    func use(on weapon: Weapon) {
        // Do nothing - weapon has infinite durability
    }

    func calculateBasePurchasePrice() -> Int {
        return 500
    }
    
}
