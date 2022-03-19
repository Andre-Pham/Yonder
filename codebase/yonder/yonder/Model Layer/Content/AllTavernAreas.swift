//
//  AllTavernAreas.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

let TAVERN_AREAS_STAGE0: [TavernArea] = [
    // Testing for now
    TavernArea(
        restorer: RestorerLocation(restorer: Restorers.newTestRestorer()),
        potionShop: ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
        enhancer: EnhancerLocation(enhancer: Enhancers.newTestEnhancer()))
]

let TAVERN_AREAS_STAGE1: [TavernArea] = [
    // Testing for now
    TavernArea(
        restorer: RestorerLocation(restorer: Restorers.newTestRestorer()),
        potionShop: ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
        enhancer: EnhancerLocation(enhancer: Enhancers.newTestEnhancer()))
]
