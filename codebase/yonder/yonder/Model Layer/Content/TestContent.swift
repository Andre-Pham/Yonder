//
//  TestContent.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

enum TestContent {
    
    // MARK: - Map
    
    static func newMap() -> Map {
        let mapPool = MapPool(
            territoryPoolsInStageOrder: [
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(1), Self.newTestAreaPool(2)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(3), Self.newTestAreaPool(4)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(5), Self.newTestAreaPool(6)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(7), Self.newTestAreaPool(8)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(9), Self.newTestAreaPool(10)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Self.newTestAreaPool(11), Self.newTestAreaPool(12)],
                    tavernAreas: [Self.newTestTavernArea()]
                ),
            ],
            bossAreaPoolsInOrder: [
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
            ])
        
        return MapGenerator().generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
    static func newTestAreaPool(_ number: Int) -> AreaPool {
        return AreaPool(
            areaName: "TEST AREA \(number)",
            areaDescription: "placeholderDescription \(number)",
            areaImage: YonderImages.placeholderImage,
            hostileLocations: [
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
                HostileLocation(foe: Self.newTestFoe()),
            ],
            challengeHostileLocations: [
                ChallengeHostileLocation(foe: Self.newTestFoe()),
                ChallengeHostileLocation(foe: Self.newTestFoe()),
                ChallengeHostileLocation(foe: Self.newTestFoe()),
                ChallengeHostileLocation(foe: Self.newTestFoe()),
                ChallengeHostileLocation(foe: Self.newTestFoe()),
                ChallengeHostileLocation(foe: Self.newTestFoe()),
            ],
            shopLocations: [
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
                ShopLocation(shopKeeper: Self.newTestShopKeeper()),
            ],
            enhancerLocations: [
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
                EnhancerLocation(enhancer: Self.newTestEnhancer()),
            ],
            restorerLocations: [
                RestorerLocation(restorer: Self.newTestRestorer()),
                RestorerLocation(restorer: Self.newTestRestorer()),
                RestorerLocation(restorer: Self.newTestRestorer()),
                RestorerLocation(restorer: Self.newTestRestorer()),
                RestorerLocation(restorer: Self.newTestRestorer()),
                RestorerLocation(restorer: Self.newTestRestorer()),
            ],
            friendlyLocations: [
                FriendlyLocation(friendly: Self.newTestFriendly()),
                FriendlyLocation(friendly: Self.newTestFriendly()),
                FriendlyLocation(friendly: Self.newTestFriendly()),
                FriendlyLocation(friendly: Self.newTestFriendly()),
                FriendlyLocation(friendly: Self.newTestFriendly()),
                FriendlyLocation(friendly: Self.newTestFriendly()),
            ]
        )
    }
    
    // MARK: - Foes
    
    static func newTestFoe() -> Foe {
        let lootBag1 = LootBag()
        lootBag1.addGoldLoot(500)
        lootBag1.addArmorLoot(Armor(name: "Armor Loot", description: "Some weak armor.", type: .legs, armorPoints: 200, armorBuffs: [DamageBuff(sourceName: "Armor Loot", direction: .outgoing, duration: nil, damageDifference: 5)], equipmentPills: []))
        let lootBag2 = LootBag()
        lootBag2.addPotionLoot(DamagePotion(tier: .I, potionCount: 4))
        lootBag2.addPotionLoot(HealthRestorationPotion(tier: .V, potionCount: 4))
        let lootBag3 = LootBag()
        lootBag3.addWeaponLoot(Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DecrementDurabilityPill(durability: 5), effectPills: [LifestealEffectPill(lifestealFraction: 0.5)]))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Loot", description: "This is some spooky armor.", type: .regular, healthBonus: 100, armorPointsBonus: 0, buffs: [], equipmentPills: []))
        lootBag3.addAccessoryLoot(Accessory(name: "Accessory Peri Loot", description: "This is some scary armor.", type: .peripheral, healthBonus: 0, armorPointsBonus: 100, buffs: [], equipmentPills: []))
        
        return Foe(
            maxHealth: 200,
            weapon: BaseAttack(damage: 100),
            loot: LootOptions(lootBag1, lootBag2, lootBag3)
        )
    }
    
    // MARK: - Armor
    
    static func newTestHeadArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .head, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    static func newTestBodyArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .body, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    static func newTestLegsArmor() -> Armor {
        return Armor(name: "Resistance Armor", description: "Very resistive.", type: .legs, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [])
    }
    
    // MARK: - Interactors
    
    static func newTestEnhancer() -> Enhancer {
        return Enhancer(offers: [ArmorPointsEnhanceOffer(price: 10, armorPoints: 50), EnhanceOffers.lifestealForWeapon(stage: 0)])
    }
    
    static func newTestFriendly() -> Friendly {
        return Friendly(
            offers: [
                FreeGoldOffer(goldAmount: 500),
                PurchaseWeaponOffer(weapon: Weapon(basePill: DamageBasePill(damage: 500), durabilityPill: InfiniteDurabilityPill()), price: 400)
            ],
            offerLimit: 2)
    }
    
    static func newTestRestorer() -> Restorer {
        return Restorer(options: [.armorPoints, .health], pricePerHealthBundle: 10, pricePerArmorPointBundle: 15)
    }
    
    static func newTestShopKeeper() -> ShopKeeper {
        return ShopKeeper(purchasableItems: [
            PurchasableItem(item: Accessory(name: "Damage/Health Accessory", description: "Very sharp, be careful while holding!", type: .regular, healthBonus: 50, armorPointsBonus: 0, buffs: [DamagePercentBuff(sourceName: "Damage/Health Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)], equipmentPills: []), stock: 5),
            PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)), stock: 5),
            PurchasableItem(item: Armor(name: "Strong Armor", description: "The toughest armor out there.", type: .body, armorPoints: 200, armorBuffs: [], equipmentPills: []), stock: 1),
            PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 3), stock: 5)
        ])
    }
    
    static func newTestTavernArea() -> TavernArea {
        return TavernArea(
            restorer: RestorerLocation(restorer: Self.newTestRestorer()),
            potionShop: ShopLocation(shopKeeper: Self.newTestShopKeeper()),
            enhancer: EnhancerLocation(enhancer: Self.newTestEnhancer())
        )
    }
    
}
