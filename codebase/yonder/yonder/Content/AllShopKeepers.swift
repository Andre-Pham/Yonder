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
            PurchasableItem(item: Weapons.newTestBasicWeapon(), stock: 5)
        ])
    }
    
    // MARK:  - Stage 0
    
}
