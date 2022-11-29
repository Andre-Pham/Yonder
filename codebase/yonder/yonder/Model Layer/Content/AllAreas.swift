//
//  AllLocations.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

enum Areas {
    
    // TODO: Remove
    static func newTestAreaPool(_ number: Int) -> AreaPool {
        return AreaPool(
            areaName: "TEST AREA \(number)",
            areaDescription: "placeholderDescription \(number)",
            areaImage: YonderImages.placeholderImage,
            hostileLocations: [
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
                HostileLocation(foe: Foes.newTestFoe()),
            ],
            challengeHostileLocations: [
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
                ChallengeHostileLocation(foe: Foes.newTestFoe()),
            ],
            shopLocations: [
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
                ShopLocation(shopKeeper: ShopKeepers.newTestShopKeeper()),
            ],
            enhancerLocations: [
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
                EnhancerLocation(enhancer: Enhancers.newTestEnhancer()),
            ],
            restorerLocations: [
                RestorerLocation(restorer: Restorers.newTestRestorer()),
                RestorerLocation(restorer: Restorers.newTestRestorer()),
                RestorerLocation(restorer: Restorers.newTestRestorer()),
                RestorerLocation(restorer: Restorers.newTestRestorer()),
                RestorerLocation(restorer: Restorers.newTestRestorer()),
                RestorerLocation(restorer: Restorers.newTestRestorer()),
            ],
            friendlyLocations: [
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
                FriendlyLocation(friendly: Friendlies.newTestFriendly()),
            ]
        )
    }
    
}
