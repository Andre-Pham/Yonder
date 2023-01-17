//
//  ContentManager.swift
//  yonder
//
//  Created by Andre Pham on 6/1/2023.
//

import Foundation

class ContentManager: Storable, OnPlayerTravelSubscriber, AfterStageChangeSubscriber, AfterGameContextInitSubscriber {
    
    // TODO:
    // 1. Add recycleProfiles to the remaining factories/buckets (refer to what i've done with WeaponFactory)
    // 2. Make all context classes storable and then finish making GameContext storable
    // 3. I need to update all the locations to implement their initContent methods and make them start with nil content
    // 4. I'll need to implement tavern areas and boss area locations and warp locations receiving a LocationContext
    // 5. I need to update how the MapPoolFactory and its dependencies generate the map now that factories aren't needed during this process
        // UP TO:
    // 6. When everything is working, go through every edited file and make sure it is serialising correctly
    // 7. Go through all files and start serialising the id of objects - this should be the new standard
    // (Things get too messy if we don't serialise the id and then later we need it to remain persistent)
    // NOTE: when saving/restoring this, don't serialise all the content factories. just call self.resetFactories then serialise the buckets. this also has the added bonus of not requiring stuff like weapons to serialise their id.
    // 8. Go through the content bundles and such and see which aren't being used
    // 9. Refactor everything and clean up. AreaThemed and AreaProfileTagAllocation are misleading names
    // (Also add documentation)
    // (Also draw a diagram of the flow of everything and add it to the documentation)
    // (AreaProfiles aren't just used for Areas for they should be given a new name)
    
    private let accessoryProfileBucket: AccessoryProfileBucket
    private let armorProfileBucket: ArmorProfileBucket
    private let weaponProfileBucket: WeaponProfileBucket
    private let foeProfileBucket: FoeProfileBucket
    private let shopKeeperProfileBucket: ShopKeeperProfileBucket
    private let enhancerProfileBucket: EnhancerProfileBucket
    private let restorerProfileBucket: RestorerProfileBucket
    private let friendlyProfileBucket: FriendlyProfileBucket
    
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
    
    init() {
        self.accessoryProfileBucket = AccessoryProfileBucket()
        self.armorProfileBucket = ArmorProfileBucket()
        self.weaponProfileBucket = WeaponProfileBucket()
        self.foeProfileBucket = FoeProfileBucket()
        self.shopKeeperProfileBucket = ShopKeeperProfileBucket()
        self.enhancerProfileBucket = EnhancerProfileBucket()
        self.restorerProfileBucket = RestorerProfileBucket()
        self.friendlyProfileBucket = FriendlyProfileBucket()
        
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
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterStageChangePublisher.subscribe(self)
        AfterGameContextInitPublisher.subscribe(self)
    }

    func toDataObject() -> DataObject {
        self.resetFactories()
        return DataObject(self)
            .add(key: Field.accessoryProfileBucket.rawValue, value: self.accessoryProfileBucket)
            .add(key: Field.armorProfileBucket.rawValue, value: self.armorProfileBucket)
            .add(key: Field.weaponProfileBucket.rawValue, value: self.weaponProfileBucket)
            .add(key: Field.foeProfileBucket.rawValue, value: self.foeProfileBucket)
            .add(key: Field.shopKeeperProfileBucket.rawValue, value: self.shopKeeperProfileBucket)
            .add(key: Field.enhancerProfileBucket.rawValue, value: self.enhancerProfileBucket)
            .add(key: Field.restorerProfileBucket.rawValue, value: self.restorerProfileBucket)
            .add(key: Field.friendlyProfileBucket.rawValue, value: self.friendlyProfileBucket)
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
        // Recycle profiles (restore unused profiles to their respective profile bucket)
        self.activeWeaponFactories.forEach({ $0.value.recycleProfiles() })
            // (Potion factory doesn't use profiles)
        self.activeArmorFactories.forEach({ $0.value.recycleProfiles() })
        self.activeAccessoryFactories.forEach({ $0.value.recycleProfiles() })
            // (Consumable factory doesn't use profiles)
        self.activeHostileFactories.forEach({ $0.value.recycleProfiles() })
            // (ShopKeeper factory doesn't maintain a supply)
            // (Enhancer factory doesn't maintain a supply)
        self.activeRestorerFactories.forEach({ $0.value.recycleProfiles() })
        self.activeFriendlyFactories.forEach({ $0.value.recycleProfiles() })
        
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
