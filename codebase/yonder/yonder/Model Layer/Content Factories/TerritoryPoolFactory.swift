//
//  TerritoryPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class TerritoryPoolFactory {
    
    private let accessoryProfileBucket = AccessoryProfileBucket()
    private let armorProfileBucket = ArmorProfileBucket()
    private let weaponProfileBucket = WeaponProfileBucket()
    private let foeProfileBucket = FoeProfileBucket()
    private let shopKeeperProfileBucket = ShopKeeperProfileBucket()
    private let enhancerProfileBucket = EnhancerProfileBucket()
    private let restorerProfileBucket = RestorerProfileBucket()
    private let friendlyProfileBucket = FriendlyProfileBucket()
    private let areaProfileBucket = AreaProfileBucket()
    
    func deliver(stage: Int) -> TerritoryPool {
        var areaPools = [AreaPool]()
        var tavernAreas = [TavernArea]()
        
        let areaProfiles = self.areaProfileBucket.grabProfiles(count: 2, stage: stage)
        for areaProfile in areaProfiles {
            let lootFactories = LootFactoryBundle(
                weapons: WeaponFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    profileBucket: self.weaponProfileBucket
                ),
                potions: PotionFactory(
                    stage: stage
                ),
                armors: ArmorFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    profileBucket: self.armorProfileBucket
                ),
                accessories: AccessoryFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    profileBucket: self.accessoryProfileBucket
                ),
                consumables: ConsumableFactory(
                    stage: stage
                )
            )
            let interactorFactories = InteractorFactoryBundle(
                shopKeeperFactory: ShopKeeperFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    shopKeeperBucket: self.shopKeeperProfileBucket,
                    lootFactories: lootFactories
                ),
                enhancerFactory: EnhancerFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    enhancerProfileBucket: self.enhancerProfileBucket
                ),
                restorerFactory: RestorerFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    restorerProfileBucket: self.restorerProfileBucket
                ),
                friendlyFactory: FriendlyFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    friendlyProfileBucket: self.friendlyProfileBucket,
                    lootFactory: lootFactories
                )
            )
            let challengeLootFactories = LootFactoryBundle(
                weapons: WeaponFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.weaponProfileBucket),
                potions: PotionFactory(stage: stage + 3),
                armors: ArmorFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.armorProfileBucket),
                accessories: AccessoryFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.accessoryProfileBucket),
                consumables: ConsumableFactory(stage: stage + 3)
            )
            let areaFactories = AreaFactoryBundle(
                interactors: interactorFactories,
                foes: FoeFactory(
                    stage: stage,
                    areaTags: areaProfile.tags,
                    profileBucket: self.foeProfileBucket,
                    lootFactoryBundle: lootFactories
                ),
                challengeHostiles: FoeFactory(
                    stage: stage + 2,
                    areaTags: areaProfile.tags,
                    profileBucket: self.foeProfileBucket,
                    lootFactoryBundle: challengeLootFactories
                )
            )
            let areaPoolFactory = AreaPoolFactory(areaProfile: areaProfile, factoryBundle: areaFactories)
            let tavernAreaFactory = TavernAreaFactory(stage: stage, factoryBundle: areaFactories)
            areaPools.append(areaPoolFactory.deliver())
            tavernAreas.append(tavernAreaFactory.deliver())
        }
        
        return TerritoryPool(
            areaPools: areaPools,
            tavernAreas: tavernAreas
        )
    }
    
    func deliver(count: Int) -> [TerritoryPool] {
        var territoryPools = [TerritoryPool]()
        for stage in 0..<count {
            territoryPools.append(self.deliver(stage: stage))
        }
        return territoryPools
    }
    
}
