//
//  AllShops.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum ShopKeepers {
    
    // MARK: - Test ShopKeepers
    
    static func newTestShopKeeper() -> ShopKeeper {
        return ShopKeeper(purchasableItems: [
            PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 50, durability: 5), durabilityPill: DecrementDurabilityPill()), stock: 5)
        ])
    }
    
    // MARK:  - Stage 0
    
}
