//
//  ShopLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ShopLocation: LocationAbstract {
    
    private(set) var shopKeeper: ShopKeeper
    public let type: LocationType = .shop
    
    init(shopKeeper: ShopKeeper, locationBridgeAccessibility: LocationBridgeAccessibility) {
        self.shopKeeper = shopKeeper
        
        super.init(locationBridgeAccessibility: locationBridgeAccessibility)
    }
    
}
