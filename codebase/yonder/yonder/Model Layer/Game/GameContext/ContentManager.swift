//
//  ContentManager.swift
//  yonder
//
//  Created by Andre Pham on 6/1/2023.
//

import Foundation

class ContentManager: Storable, OnPlayerTravelSubscriber, AfterStageChangeSubscriber, AfterGameContextInitSubscriber {
    
    private let accessoryProfileBucket: AccessoryProfileBucket
    private let armorProfileBucket: ArmorProfileBucket
    private let weaponProfileBucket: WeaponProfileBucket
    private let foeProfileBucket: FoeProfileBucket
    private let bossProfileBucket: BossProfileBucket
    private let shopKeeperProfileBucket: ShopKeeperProfileBucket
    private let enhancerProfileBucket: EnhancerProfileBucket
    private let restorerProfileBucket: RestorerProfileBucket
    private let friendlyProfileBucket: FriendlyProfileBucket
    
    private var interactorProfileBuckets: [InteractorProfileBucket] {
        return [
            self.shopKeeperProfileBucket,
            self.enhancerProfileBucket,
            self.restorerProfileBucket,
            self.friendlyProfileBucket,
        ]
    }
    
    private var activeWeaponFactories = [String: WeaponFactory]()
    private var activePotionFactories = [String: PotionFactory]()
    private var activeArmorFactories = [String: ArmorFactory]()
    private var activeAccessoryFactories = [String: AccessoryFactory]()
    private var activeConsumableFactories = [String: ConsumableFactory]()
    private var activeHostileFactories = [String: FoeFactory]()
    private var activeBossFactories = [String: BossFactory]()
    private var activeShopKeeperFactories = [String: ShopKeeperFactory]()
    private var activeEnhancerFactories = [String: EnhancerFactory]()
    private var activeRestorerFactories = [String: RestorerFactory]()
    private var activeFriendlyFactories = [String: FriendlyFactory]()
    
    private var weaponBuildTokenCache: [BuildTokenCache]
    private var potionBuildTokenCache: [BuildTokenCache]
    private var armorBuildTokenCache: [BuildTokenCache]
    private var accessoryBuildTokenCache: [BuildTokenCache]
    private var consumableBuildTokenCache: [BuildTokenCache]
    private var hostileBuildTokenCache: [BuildTokenCache]
    // > Bosses don't have build tokens
    // > ShopKeepers don't have build tokens
    // > Enhancers don't have build tokens
    private var restorerBuildTokenCache: [BuildTokenCache]
    private var friendlyBuildTokenCache: [BuildTokenCache]
    
    init() {
        self.accessoryProfileBucket = AccessoryProfileBucket()
        self.armorProfileBucket = ArmorProfileBucket()
        self.weaponProfileBucket = WeaponProfileBucket()
        self.foeProfileBucket = FoeProfileBucket()
        self.bossProfileBucket = BossProfileBucket()
        self.shopKeeperProfileBucket = ShopKeeperProfileBucket()
        self.enhancerProfileBucket = EnhancerProfileBucket()
        self.restorerProfileBucket = RestorerProfileBucket()
        self.friendlyProfileBucket = FriendlyProfileBucket()
        
        self.weaponBuildTokenCache = [BuildTokenCache]()
        self.potionBuildTokenCache = [BuildTokenCache]()
        self.armorBuildTokenCache = [BuildTokenCache]()
        self.accessoryBuildTokenCache = [BuildTokenCache]()
        self.consumableBuildTokenCache = [BuildTokenCache]()
        self.hostileBuildTokenCache = [BuildTokenCache]()
        // > Bosses don't have build tokens
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restorerBuildTokenCache = [BuildTokenCache]()
        self.friendlyBuildTokenCache = [BuildTokenCache]()
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterStageChangePublisher.subscribe(self)
        AfterGameContextInitPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case accessoryProfileBucket
        case armorProfileBucket
        case weaponProfileBucket
        case foeProfileBucket
        case bossProfileBucket
        case shopKeeperProfileBucket
        case enhancerProfileBucket
        case restorerProfileBucket
        case friendlyProfileBucket
        case weaponBuildTokens
        case potionBuildTokens
        case armorBuildTokens
        case accessoryBuildTokens
        case consumableBuildTokens
        case hostileBuildTokens
        case restorerBuildTokens
        case friendlyBuildTokens
    }

    required init(dataObject: DataObject) {
        self.accessoryProfileBucket = dataObject.getObject(Field.accessoryProfileBucket.rawValue, type: AccessoryProfileBucket.self)
        self.armorProfileBucket = dataObject.getObject(Field.armorProfileBucket.rawValue, type: ArmorProfileBucket.self)
        self.weaponProfileBucket = dataObject.getObject(Field.weaponProfileBucket.rawValue, type: WeaponProfileBucket.self)
        self.foeProfileBucket = dataObject.getObject(Field.foeProfileBucket.rawValue, type: FoeProfileBucket.self)
        self.bossProfileBucket = dataObject.getObject(Field.bossProfileBucket.rawValue, type: BossProfileBucket.self)
        self.shopKeeperProfileBucket = dataObject.getObject(Field.shopKeeperProfileBucket.rawValue, type: ShopKeeperProfileBucket.self)
        self.enhancerProfileBucket = dataObject.getObject(Field.enhancerProfileBucket.rawValue, type: EnhancerProfileBucket.self)
        self.restorerProfileBucket = dataObject.getObject(Field.restorerProfileBucket.rawValue, type: RestorerProfileBucket.self)
        self.friendlyProfileBucket = dataObject.getObject(Field.friendlyProfileBucket.rawValue, type: FriendlyProfileBucket.self)
        
        self.weaponBuildTokenCache = dataObject.getObjectArray(Field.weaponBuildTokens.rawValue, type: BuildTokenCache.self)
        self.potionBuildTokenCache = dataObject.getObjectArray(Field.potionBuildTokens.rawValue, type: BuildTokenCache.self)
        self.armorBuildTokenCache = dataObject.getObjectArray(Field.armorBuildTokens.rawValue, type: BuildTokenCache.self)
        self.accessoryBuildTokenCache = dataObject.getObjectArray(Field.accessoryBuildTokens.rawValue, type: BuildTokenCache.self)
        self.consumableBuildTokenCache = dataObject.getObjectArray(Field.consumableBuildTokens.rawValue, type: BuildTokenCache.self)
        self.hostileBuildTokenCache = dataObject.getObjectArray(Field.hostileBuildTokens.rawValue, type: BuildTokenCache.self)
        // > Bosses don't have build tokens
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restorerBuildTokenCache = dataObject.getObjectArray(Field.restorerBuildTokens.rawValue, type: BuildTokenCache.self)
        self.friendlyBuildTokenCache = dataObject.getObjectArray(Field.friendlyBuildTokens.rawValue, type: BuildTokenCache.self)
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterStageChangePublisher.subscribe(self)
        AfterGameContextInitPublisher.subscribe(self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            // Profile buckets
            .add(key: Field.accessoryProfileBucket.rawValue, value: self.accessoryProfileBucket)
            .add(key: Field.armorProfileBucket.rawValue, value: self.armorProfileBucket)
            .add(key: Field.weaponProfileBucket.rawValue, value: self.weaponProfileBucket)
            .add(key: Field.foeProfileBucket.rawValue, value: self.foeProfileBucket)
            .add(key: Field.bossProfileBucket.rawValue, value: self.bossProfileBucket)
            .add(key: Field.shopKeeperProfileBucket.rawValue, value: self.shopKeeperProfileBucket)
            .add(key: Field.enhancerProfileBucket.rawValue, value: self.enhancerProfileBucket)
            .add(key: Field.restorerProfileBucket.rawValue, value: self.restorerProfileBucket)
            .add(key: Field.friendlyProfileBucket.rawValue, value: self.friendlyProfileBucket)
            // Build token caches
            .add(
                key: Field.weaponBuildTokens.rawValue,
                value: self.activeWeaponFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.weaponBuildTokenCache
            )
            .add(
                key: Field.potionBuildTokens.rawValue,
                value: self.activePotionFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.potionBuildTokenCache
            )
            .add(
                key: Field.armorBuildTokens.rawValue,
                value: self.activeArmorFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.armorBuildTokenCache
            )
            .add(
                key: Field.accessoryBuildTokens.rawValue,
                value: self.activeAccessoryFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.accessoryBuildTokenCache
            )
            .add(
                key: Field.consumableBuildTokens.rawValue,
                value: self.activeConsumableFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.consumableBuildTokenCache
            )
            .add(
                key: Field.hostileBuildTokens.rawValue,
                value: self.activeHostileFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.hostileBuildTokenCache
            )
            // > Bosses don't have build tokens
            // > ShopKeepers don't have build tokens
            // > Enhancers don't have build tokens
            .add(
                key: Field.restorerBuildTokens.rawValue,
                value: self.activeRestorerFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.restorerBuildTokenCache
            )
            .add(
                key: Field.friendlyBuildTokens.rawValue,
                value: self.activeFriendlyFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.friendlyBuildTokenCache
            )
    }
    
    // MARK: - Functions
    
    private func lootFactoryBundle(_ id: String) -> LootFactoryBundle {
        return LootFactoryBundle(
            weapons: self.activeWeaponFactories[id]!,
            potions: self.activePotionFactories[id]!,
            armors: self.activeArmorFactories[id]!,
            accessories: self.activeAccessoryFactories[id]!,
            consumables: self.activeConsumableFactories[id]!
        )
    }
    
    private func convertToChallengeKey(_ id: String) -> String {
        return id + "-C"
    }
    
    private func resetFactories() {
        // Remove all active factories
        self.activeWeaponFactories.removeAll()
        self.activePotionFactories.removeAll()
        self.activeArmorFactories.removeAll()
        self.activeAccessoryFactories.removeAll()
        self.activeConsumableFactories.removeAll()
        self.activeHostileFactories.removeAll()
        self.activeBossFactories.removeAll()
        self.activeShopKeeperFactories.removeAll()
        self.activeEnhancerFactories.removeAll()
        self.activeRestorerFactories.removeAll()
        self.activeFriendlyFactories.removeAll()
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        guard !newLocation.hasBeenVisited else {
            return
        }
        newLocation.initContent(using: self)
        
        // After the player has travelled to a new location and its content has loaded
        // If it's an interactor location, ensure no future interactors have the same profile
        if let interactor = (newLocation as? InteractorLocation)?.getInteractor(),
           let contentID = interactor.contentID {
            self.purgeInteractorContentID(contentID)
        }
    }
    
    /// Purges the content id of a particular profile in all interactor profile buckets (because they share profiles).
    /// - Parameters:
    ///   - id: The content id (profile id) to be removed in all interactor profile buckets
    private func purgeInteractorContentID(_ id: String) {
        self.interactorProfileBuckets.forEach({ $0.markProfileIDUsed(id: id) })
    }
    
    func afterGameContextInit(gameContext: GameContext) {
        // When the game context is created, set up the factories
        // (Since a stage change isn't triggered on initialisation)
        self.afterStageChange(newStage: gameContext.playerStageManager.stage)
    }
    
    func afterStageChange(newStage: Int) {
        self.resetFactories()
        let map = Game.gameContextAccess.map
        let territory = map.territoriesInOrder[newStage]
        // Every region (i.e. areas, tavern areas, boss areas) can generate every type of location
        // Hence we generate every type of factory for each, so that if the player needs to
        // generate, say, a weapon, it doesn't matter what region they are (where they are in the map),
        // there'll be a factory that they can use to generate it
        //
        // The only exception is boss areas - they don't need content generation, and only need the boss factory
        // We do their regions (boss areas) here:
        let bossArea: Region = map.bossAreasInOrder[newStage]
        self.activeBossFactories[bossArea.getRegionKey()] = BossFactory(
            stage: newStage,
            regionTags: bossArea.tags,
            profileBucket: self.bossProfileBucket
        )
        // ...And then we do the rest of the regions (that DO require the generation of all types of content)
        var regions = [Region]()
        regions.append(contentsOf: territory.segment.allAreas)
        regions.append(territory.tavernArea)
        for region in regions {
            // Regular
            self.activeWeaponFactories[region.getRegionKey()] = WeaponFactory(
                stage: newStage,
                regionTags: region.tags,
                profileBucket: self.weaponProfileBucket
            )
            // Challenge
            self.activeWeaponFactories[self.convertToChallengeKey(region.getRegionKey())] = WeaponFactory(
                stage: newStage + 2,
                regionTags: region.tags,
                profileBucket: self.weaponProfileBucket
            )
            // Regular
            self.activePotionFactories[region.getRegionKey()] = PotionFactory(
                stage: newStage
            )
            // Challenge
            self.activePotionFactories[self.convertToChallengeKey(region.getRegionKey())] = PotionFactory(
                stage: newStage + 2
            )
            // Regular
            self.activeArmorFactories[region.getRegionKey()] = ArmorFactory(
                stage: newStage,
                regionTags: region.tags,
                profileBucket: self.armorProfileBucket
            )
            // Challenge
            self.activeArmorFactories[self.convertToChallengeKey(region.getRegionKey())] = ArmorFactory(
                stage: newStage + 2,
                regionTags: region.tags,
                profileBucket: self.armorProfileBucket
            )
            // Regular
            self.activeAccessoryFactories[region.getRegionKey()] = AccessoryFactory(
                stage: newStage,
                regionTags: region.tags,
                profileBucket: self.accessoryProfileBucket
            )
            // Challenge
            self.activeAccessoryFactories[self.convertToChallengeKey(region.getRegionKey())] = AccessoryFactory(
                stage: newStage + 2,
                regionTags: region.tags,
                profileBucket: self.accessoryProfileBucket
            )
            // Regular
            self.activeConsumableFactories[region.getRegionKey()] = ConsumableFactory(
                stage: newStage
            )
            // Challenge
            self.activeConsumableFactories[self.convertToChallengeKey(region.getRegionKey())] = ConsumableFactory(
                stage: newStage + 2
            )
            // Regular
            self.activeHostileFactories[region.getRegionKey()] = FoeFactory(
                stage: newStage,
                regionTags: region.tags,
                profileBucket: self.foeProfileBucket,
                lootFactoryBundle: self.lootFactoryBundle(region.getRegionKey())
            )
            // Challenge
            self.activeHostileFactories[self.convertToChallengeKey(region.getRegionKey())] = FoeFactory(
                stage: newStage + 3,
                regionTags: region.tags,
                profileBucket: self.foeProfileBucket,
                lootFactoryBundle: self.lootFactoryBundle(self.convertToChallengeKey(region.getRegionKey()))
            )
            // Interactors
            self.activeShopKeeperFactories[region.getRegionKey()] = ShopKeeperFactory(
                stage: newStage,
                regionTags: region.tags,
                shopKeeperBucket: self.shopKeeperProfileBucket,
                lootFactories: self.lootFactoryBundle(region.getRegionKey())
            )
            self.activeEnhancerFactories[region.getRegionKey()] = EnhancerFactory(
                stage: newStage,
                regionTags: region.tags,
                enhancerProfileBucket: self.enhancerProfileBucket
            )
            self.activeRestorerFactories[region.getRegionKey()] = RestorerFactory(
                stage: newStage,
                regionTags: region.tags,
                restorerProfileBucket: self.restorerProfileBucket
            )
            self.activeFriendlyFactories[region.getRegionKey()] = FriendlyFactory(
                stage: newStage,
                regionTags: region.tags,
                friendlyProfileBucket: self.friendlyProfileBucket,
                lootFactory: self.lootFactoryBundle(region.getRegionKey())
            )
        }
        self.restoreAllAvailableBuildTokenCaches()
    }
    
    private func restoreAllAvailableBuildTokenCaches() {
        self.restoreBuildTokenCaches(for: self.activeWeaponFactories, caches: &self.weaponBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activePotionFactories, caches: &self.potionBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeArmorFactories, caches: &self.armorBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeAccessoryFactories, caches: &self.accessoryBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeConsumableFactories, caches: &self.consumableBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeHostileFactories, caches: &self.hostileBuildTokenCache)
        // > Bosses don't have build tokens
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restoreBuildTokenCaches(for: self.activeRestorerFactories, caches: &self.restorerBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeFriendlyFactories, caches: &self.friendlyBuildTokenCache)
    }
    
    private func restoreBuildTokenCaches(for factories: [String: any BuildTokenFactory], caches: inout [BuildTokenCache]) {
        var failedCaches = 0
        for cache in caches {
            if let factory = factories[cache.regionKey] {
                factory.importSerialisedTokens(cache)
            } else {
                failedCaches += 1
            }
        }
        
        assert(failedCaches == 0, "Cache couldn't be restored - see comment attached")
        // The most likely cause of this is multiple Game instances occurring at once. 
        // This means multiple ContentManager instances, which all subscribe to AfterGameContextInitPublisher.
        // Because Game is a singleton, there only exists one map.
        // When multiple instances of ContentManager exist, each have their AfterGameContextInitPublisher triggered.
        // However they all access the same Map, because it's a singleton. This means they try to match region keys that don't exist in the game they belong to.
        // Be cautious in unit tests which can run in parallel, which can cause multiple Game instances to exist at once.
        
        // Caches have been restored - they can be discarded
        // After recreating the factories, if any couldn't be restored, they never will be anyways
        caches.removeAll()
    }
    
    func generateHostile(using locationContext: LocationContext) -> Foe {
        let factory = self.activeHostileFactories[locationContext.key]!
        return factory.deliver()
    }
    
    func generateChallengeHostile(using locationContext: LocationContext) -> Foe {
        let factory = self.activeHostileFactories[self.convertToChallengeKey(locationContext.key)]!
        return factory.deliver()
    }
    
    func generateShopKeeper(using locationContext: LocationContext) -> ShopKeeper {
        let factory = self.activeShopKeeperFactories[locationContext.key]!
        return factory.deliver()
    }
    
    func generateEnhancer(using locationContext: LocationContext) -> Enhancer {
        let factory = self.activeEnhancerFactories[locationContext.key]!
        return factory.deliver()
    }
    
    func generateRestorer(using locationContext: LocationContext) -> Restorer {
        let factory = self.activeRestorerFactories[locationContext.key]!
        return factory.deliver()
    }
    
    func generateFriendly(using locationContext: LocationContext) -> Friendly {
        let factory = self.activeFriendlyFactories[locationContext.key]!
        return factory.deliver()
    }
    
    func generateBoss(using locationContext: LocationContext) -> Foe {
        let factory = self.activeBossFactories[locationContext.key]!
        return factory.deliver()
    }
    
    // Profile assignment functions below are so locations, when their content is generated, can check if their content id is nil
    // If so, it means they were passed a special NPC (e.g. see TavernAreaFactory), but never passed a profile
    // Hence they can keep their NPC but update it with a profile
    // (Refer to .initContent(:ContentManager) on classes such as ShopLocation)
    //
    // I only have written functions for NPCs that needed it (or don't) and don't require additional context when retrieving profiles from buckets
    // If this was required to be extended to other NPCs or types, I would need to extend each of their class data to maintain a reference to their "profile type"
    // For instance, Foe's FoeProfileTag, Friendly's FriendlyProfileTag, etc.
    // Certainly can be done - not worth the effort unless proven necessary in the future
    
    func assignShopKeeperProfile(to shopKeeper: ShopKeeper, using locationContext: LocationContext) {
        guard shopKeeper.contentID == nil else {
            assertionFailure("Shop keepers already with a profile shouldn't need re-assignment")
            return
        }
        let factory = self.activeShopKeeperFactories[locationContext.key]!
        let areaTag = factory.deliverRegionTag()
        let profile = self.shopKeeperProfileBucket.grabProfile(areaTag: areaTag)
        shopKeeper.overrideProfileContent(contentID: profile.id, name: profile.shopKeeperName, description: profile.shopKeeperDescription)
    }
    
    func assignEnhancerProfile(to enhancer: Enhancer, using locationContext: LocationContext) {
        guard enhancer.contentID == nil else {
            assertionFailure("Enhancers already with a profile shouldn't need re-assignment")
            return
        }
        let factory = self.activeEnhancerFactories[locationContext.key]!
        let areaTag = factory.deliverRegionTag()
        let profile = self.enhancerProfileBucket.grabProfile(areaTag: areaTag)
        enhancer.overrideProfileContent(contentID: profile.id, name: profile.enhancerName, description: profile.enhancerDescription)
    }
    
    func assignRestorerProfile(to restorer: Restorer, using locationContext: LocationContext) {
        guard restorer.contentID == nil else {
            assertionFailure("Restorers already with a profile shouldn't need re-assignment")
            return
        }
        let factory = self.activeRestorerFactories[locationContext.key]!
        let areaTag = factory.deliverRegionTag()
        let profile = self.restorerProfileBucket.grabProfile(areaTag: areaTag, restoreOptions: restorer.options)
        restorer.overrideProfileContent(contentID: profile.id, name: profile.restorerName, description: profile.restorerDescription)
    }
    
}
