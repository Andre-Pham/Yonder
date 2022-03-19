//
//  AllLocations.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

let AREA_POOLS_STAGE_ORDERED: [[AreaPool]] = [
    
    // MARK: - Stage 0
    [
        
        AreaPool(
            areaName: "Overgrown Ironbark",
            areaDescription: "placeholderDescription",
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
        ),
        
        AreaPool(
            areaName: "Overgrown Ironbark 2",
            areaDescription: "placeholderDescription",
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
        ),
        
    ],
    
    // MARK: - Stage 1
    [
        
        AreaPool(
            areaName: "Glacier Rifts",
            areaDescription: "placeholderDescription",
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
        ),
        
        AreaPool(
            areaName: "Glacier Rifts 2",
            areaDescription: "placeholderDescription",
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
        ),
        
    ],
    
]
