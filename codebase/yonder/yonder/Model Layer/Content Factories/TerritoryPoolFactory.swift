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
    private let areaProfileBucket = AreaProfileBucket()
    
    func deliver(stage: Int) -> TerritoryPool {
        var areaPools = [AreaPool]()
        var tavernAreas = [TavernArea]()
        
        let areaProfiles = self.areaProfileBucket.grabProfiles(count: 2, stage: stage)
        for areaProfile in areaProfiles {
            let lootFactories = LootFactoryBundle(
                weapons: WeaponFactory(stage: stage, areaTags: areaProfile.tags, profileBucket: self.weaponProfileBucket),
                potions: PotionFactory(stage: stage),
                armors: ArmorFactory(stage: stage, areaTags: areaProfile.tags, profileBucket: self.armorProfileBucket),
                accessories: AccessoryFactory(stage: stage, areaTags: areaProfile.tags, profileBucket: self.accessoryProfileBucket),
                consumables: ConsumableFactory(stage: stage)
            )
            let npcFactories = InteractorFactoryBundle(
                // TODO: Populate
            )
            let challengeLootFactories = LootFactoryBundle(
                weapons: WeaponFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.weaponProfileBucket),
                potions: PotionFactory(stage: stage + 3),
                armors: ArmorFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.armorProfileBucket),
                accessories: AccessoryFactory(stage: stage + 3, areaTags: areaProfile.tags, profileBucket: self.accessoryProfileBucket),
                consumables: ConsumableFactory(stage: stage + 3)
            )
            let areaFactories = AreaFactoryBundle(
                loot: lootFactories,
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
            let tavernAreaFactory = TavernAreaFactory(factoryBundle: areaFactories)
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
