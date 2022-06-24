//
//  AllFriendlies.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Friendlies {
    
    // MARK: - Test Friendlies
    
    static func newTestFriendly() -> Friendly {
        return Friendly(
            offers: [
                FreeGoldOffer(goldAmount: 500),
                PurchaseWeaponOffer(weapon: Weapon(basePill: DamageBasePill(damage: 500), durabilityPill: InfiniteDurabilityPill()), price: 400)
            ],
            offerLimit: 2)
    }
    
    // MARK:  - Stage 0
    
}
