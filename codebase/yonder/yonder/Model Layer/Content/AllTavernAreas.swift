//
//  AllTavernAreas.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum TavernAreas {
    
    // TODO: Remove
    static func newTestTavernArea() -> TavernArea {
        return TavernArea(
            restorer: RestorerLocation(restorer: Restorers.newTestRestorer()),
            potionShop: ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
            enhancer: EnhancerLocation(enhancer: Enhancers.newTestEnhancer())
        )
    }
    
}
