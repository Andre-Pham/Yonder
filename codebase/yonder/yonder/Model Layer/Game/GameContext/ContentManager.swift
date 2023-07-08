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
    private var activeShopKeeperFactories = [String: ShopKeeperFactory]()
    private var activeEnhancerFactories = [String: EnhancerFactory]()
    private var activeRestorerFactories = [String: RestorerFactory]()
    private var activeFriendlyFactories = [String: FriendlyFactory]()
    
    // TODO: Weapon build token cache
    // TODO: Potion build token cache
    // TODO: Armor build token cache
    // TODO: Accessory build token cache
    // TODO: Consumable build token cache
    private var hostileBuildTokenCache: [BuildTokenCache]
    // > ShopKeepers don't have build tokens
    // > Enhancers don't have build tokens
    private var restorerBuildTokenCache: [BuildTokenCache]
    private var friendlyBuildTokenCache: [BuildTokenCache]
    
    init() {
        self.accessoryProfileBucket = AccessoryProfileBucket()
        self.armorProfileBucket = ArmorProfileBucket()
        self.weaponProfileBucket = WeaponProfileBucket()
        self.foeProfileBucket = FoeProfileBucket()
        self.shopKeeperProfileBucket = ShopKeeperProfileBucket()
        self.enhancerProfileBucket = EnhancerProfileBucket()
        self.restorerProfileBucket = RestorerProfileBucket()
        self.friendlyProfileBucket = FriendlyProfileBucket()
        
        self.hostileBuildTokenCache = [BuildTokenCache]()
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restorerBuildTokenCache = [BuildTokenCache]()
        self.friendlyBuildTokenCache = [BuildTokenCache]()
        // TODO: Other build token caches
        
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
        case shopKeeperProfileBucket
        case enhancerProfileBucket
        case restorerProfileBucket
        case friendlyProfileBucket
        case hostileBuildTokens
        case restorerBuildTokens
        case friendlyBuildTokens
        // TODO: Other build token caches
    }

    required init(dataObject: DataObject) {
        self.accessoryProfileBucket = dataObject.getObject(Field.accessoryProfileBucket.rawValue, type: AccessoryProfileBucket.self)
        self.armorProfileBucket = dataObject.getObject(Field.armorProfileBucket.rawValue, type: ArmorProfileBucket.self)
        self.weaponProfileBucket = dataObject.getObject(Field.weaponProfileBucket.rawValue, type: WeaponProfileBucket.self)
        self.foeProfileBucket = dataObject.getObject(Field.foeProfileBucket.rawValue, type: FoeProfileBucket.self)
        self.shopKeeperProfileBucket = dataObject.getObject(Field.shopKeeperProfileBucket.rawValue, type: ShopKeeperProfileBucket.self)
        self.enhancerProfileBucket = dataObject.getObject(Field.enhancerProfileBucket.rawValue, type: EnhancerProfileBucket.self)
        self.restorerProfileBucket = dataObject.getObject(Field.restorerProfileBucket.rawValue, type: RestorerProfileBucket.self)
        self.friendlyProfileBucket = dataObject.getObject(Field.friendlyProfileBucket.rawValue, type: FriendlyProfileBucket.self)
        
        self.hostileBuildTokenCache = dataObject.getObjectArray(Field.hostileBuildTokens.rawValue, type: BuildTokenCache.self)
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restorerBuildTokenCache = dataObject.getObjectArray(Field.restorerBuildTokens.rawValue, type: BuildTokenCache.self)
        self.friendlyBuildTokenCache = dataObject.getObjectArray(Field.friendlyBuildTokens.rawValue, type: BuildTokenCache.self)
        // TODO: Other build token caches
        
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
            .add(key: Field.shopKeeperProfileBucket.rawValue, value: self.shopKeeperProfileBucket)
            .add(key: Field.enhancerProfileBucket.rawValue, value: self.enhancerProfileBucket)
            .add(key: Field.restorerProfileBucket.rawValue, value: self.restorerProfileBucket)
            .add(key: Field.friendlyProfileBucket.rawValue, value: self.friendlyProfileBucket)
            // Build token caches
            .add(
                key: Field.hostileBuildTokens.rawValue,
                value: self.activeHostileFactories.map({ $0.value.exportBuildTokenCache(regionKey: $0.key) }) + self.hostileBuildTokenCache
            )
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
            // TODO: Other build token caches
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
        // TODO: Remove the concept of recycling profiles
        // Recycle profiles (restore unused profiles to their respective profile bucket)
        self.activeWeaponFactories.forEach({ $0.value.recycleProfiles() })
            // (Potion factory doesn't use profiles)
        self.activeArmorFactories.forEach({ $0.value.recycleProfiles() })
        self.activeAccessoryFactories.forEach({ $0.value.recycleProfiles() })
            // (Consumable factory doesn't use profiles)
        
        // Remove all active factories
        self.activeWeaponFactories.removeAll()
        self.activePotionFactories.removeAll()
        self.activeArmorFactories.removeAll()
        self.activeAccessoryFactories.removeAll()
        self.activeConsumableFactories.removeAll()
        self.activeHostileFactories.removeAll()
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
        self.restoreBuildTokenCaches(for: self.activeHostileFactories, caches: &self.hostileBuildTokenCache)
        // > ShopKeepers don't have build tokens
        // > Enhancers don't have build tokens
        self.restoreBuildTokenCaches(for: self.activeRestorerFactories, caches: &self.restorerBuildTokenCache)
        self.restoreBuildTokenCaches(for: self.activeFriendlyFactories, caches: &self.friendlyBuildTokenCache)
        // TODO: Other build token caches
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
        assert(failedCaches == 0, "Cache couldn't be restored")
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
    
}
