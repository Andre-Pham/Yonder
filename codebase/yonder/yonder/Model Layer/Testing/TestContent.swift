//
//  TestContent.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

enum TestContent {
    
    // MARK: - Game
    
    static func testGame() -> Game {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Game.new(playerClass: .none, map: TestContent.testMap())
    }
    
    // MARK: - Map
    
    static func testMap() -> Map {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        var territoryPools = [TerritoryPool]()
        var areaNumber = 0
        territoryPools.populate(count: MapConfig.territoryCount) {
            let areaPools = [Self.testAreaPool(areaNumber + 1), Self.testAreaPool(areaNumber + 2)]
            areaNumber += 2
            return TerritoryPool(areaPools: areaPools, tavernAreas: [Self.testTavernArea()])
        }
        var bossAreaPools = [BossAreaPool]()
        bossAreaPools.populate(count: MapConfig.bossCount) {
            let bossLocations = [BossLocation(boss: Self.testBoss()), BossLocation(boss: Self.testBoss())]
            return BossAreaPool(bossLocations: bossLocations, restorerLocations: [RestorerLocation(restorer: Self.testRestorer())])
        }
        let mapPool = MapPool(territoryPoolsInStageOrder: territoryPools, bossAreaPoolsInOrder: bossAreaPools)
        return MapGenerator().generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
    static func testAreaPool(_ number: Int) -> AreaPool {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        var hostileLocations = [HostileLocation]()
        hostileLocations.populate(count: 12) { HostileLocation(foe: Self.testFoe()) }
        var challengeHostileLocations = [ChallengeHostileLocation]()
        challengeHostileLocations.populate(count: 6) { ChallengeHostileLocation(foe: Self.testFoe()) }
        var shopLocations = [ShopLocation]()
        shopLocations.populate(count: 6) { ShopLocation(shopKeeper: Self.testShopKeeper()) }
        var enhancerLocations = [EnhancerLocation]()
        enhancerLocations.populate(count: 6) { EnhancerLocation(enhancer: Self.testEnhancer()) }
        var restorerLocations = [RestorerLocation]()
        restorerLocations.populate(count: 6) { RestorerLocation(restorer: Self.testRestorer()) }
        var friendlyLocations = [FriendlyLocation]()
        friendlyLocations.populate(count: 6) { FriendlyLocation(friendly: Self.testFriendly()) }
        return AreaPool(
            areaName: "Test Area \(number)",
            areaDescription: "Test area \(number) description.",
            areaTileBackgroundImage: YonderImages.missingTileBackgroundImage,
            areaPlatformImage: YonderImages.missingPlatformImage,
            tags: RegionTagAllocation(tags: (.all, 1)),
            hostileLocations: hostileLocations,
            challengeHostileLocations: challengeHostileLocations,
            shopLocations: shopLocations,
            enhancerLocations: enhancerLocations,
            restorerLocations: restorerLocations,
            friendlyLocations: friendlyLocations
        )
    }
    
    static func testTavernArea() -> TavernArea {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return TavernArea(
            name: "Test Tavern Area",
            description: "Test tavern area.",
            tags: RegionTagAllocation(tags: (.all, 1)),
            tileBackgroundImage: YonderImages.missingTileBackgroundImage,
            platformImage: YonderImages.missingPlatformImage,
            RestorerLocation(restorer: Self.testRestorer()),
            ShopLocation(shopKeeper: Self.testShopKeeper()),
            EnhancerLocation(enhancer: Self.testEnhancer())
        )
    }
    
    // MARK: - Foes
    
    static func testFoe() -> Foe {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Foe(
            contentID: nil,
            name: "Test Foe",
            description: "Test foe description.",
            maxHealth: 200,
            weapon: BaseAttack(damage: 100),
            loot: LootOptions(Self.testLootBag(), Self.testLootBag(), Self.testLootBag())
        )
    }
    
    static func testBoss() -> Foe {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Foe(
            contentID: nil,
            name: "Test Boss",
            description: "Test boss description.",
            maxHealth: 10000,
            weapon: BaseAttack(damage: 1000),
            loot: LootOptions(Self.testLootBag(), Self.testLootBag(), Self.testLootBag())
        )
    }
    
    // MARK: - Loot
    
    static func testLootBag() -> LootBag {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        let lootBag = LootBag()
        lootBag.addGoldLoot(500)
        lootBag.addArmorLoot(Self.testBodyArmor())
        return lootBag
    }
    
    // MARK: - Armor
    
    static func testHeadArmor() -> Armor {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Armor(name: "Test Head Armor", description: "Test head armor description.", type: .head, armorPoints: 200, armorBuffs: [], equipmentPills: [])
    }
    
    static func testBodyArmor() -> Armor {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Armor(name: "Test Body Armor", description: "Test body armor description.", type: .body, armorPoints: 200, armorBuffs: [], equipmentPills: [])
    }
    
    static func testLegsArmor() -> Armor {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Armor(name: "Test Legs Armor", description: "Test legs armor description.", type: .legs, armorPoints: 200, armorBuffs: [], equipmentPills: [])
    }
    
    // MARK: - Interactors
    
    static func testEnhancer() -> Enhancer {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Enhancer(
            contentID: nil,
            offers: [
                ArmorPointsEnhanceOffer(price: 10, armorPoints: 50),
                EnhanceOffers.lifestealForWeapon(stage: 0)
            ]
        )
    }
    
    static func testFriendly() -> Friendly {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Friendly(
            contentID: nil,
            offers: [
                FreeGoldOffer(goldAmount: 500),
                PurchaseWeaponOffer(weapon: Weapon(basePill: DamageBasePill(damage: 500), durabilityPill: InfiniteDurabilityPill()), price: 400)
            ],
            offerLimit: 2
        )
    }
    
    static func testRestorer() -> Restorer {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return Restorer(contentID: "N0020", options: [.armorPoints, .health], pricePerHealthBundle: 10, pricePerArmorPointBundle: 15)
    }
    
    static func testShopKeeper() -> ShopKeeper {
        assertionFailureOutsideUnitTests("This is only to be used during unit testing")
        return ShopKeeper(contentID: nil, purchasableItems: [
            PurchasableItem(item: Accessory(name: "Damage/Health Accessory", description: "Very sharp, be careful while holding!", type: .regular, healthBonus: 50, armorPointsBonus: 0, buffs: [DamagePercentBuff(sourceName: "Damage/Health Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)], equipmentPills: []), stock: 5),
            PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)), stock: 5),
            PurchasableItem(item: Armor(name: "Strong Armor", description: "The toughest armor out there.", type: .body, armorPoints: 200, armorBuffs: [], equipmentPills: []), stock: 1),
            PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 3), stock: 5)
        ])
    }
    
}
