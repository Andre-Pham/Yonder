//
//  PreviewObjects.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

enum PreviewObjects {
    
    // MARK: - Player
    
    // MODEL
    
    private static var player: Player {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Self.armor)
        player.addStatusEffect(BurnStatusEffect(damage: 12, duration: 5))
        player.addStatusEffect(BurnStatusEffect(damage: 15, duration: 5))
        player.addTimedEvent(MaxHealthRestorationTimedEvent(timeToTrigger: 5))
        player.equipAccessory(Self.accessory, replacing: nil)
        player.addConsumable(TravelImprovingRestorationConsumable(amount: 1))
        return player
    }
    
    // VIEW MODEL
    
    static var playerViewModel: PlayerViewModel {
        return PlayerViewModel(Self.player)
    }
    
    // MARK: - Armor
    
    // MODEL
    
    private static var armor: Armor {
        return Armor(
            name: "Cool Armor",
            description: "Very cool. Looks shiny.",
            type: .body,
            armorPoints: 500,
            armorBuffs: [DamagePercentBuff(sourceName: "Cool Armor", direction: .incoming, duration: nil, damageFraction: 0.8)],
            equipmentPills: []
        )
    }
    
    // VIEW MODEL
    
    static var armorViewModel: ArmorViewModel {
        return ArmorViewModel(Self.armor)
    }
    
    // MARK: - Accessories
    
    // MODEL
    
    private static var accessory: Accessory {
        return Accessory(
            name: "Cool Accessory",
            description: "An accessory that's so very cool.",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [DamagePercentBuff(sourceName: "Cool Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)],
            equipmentPills: []
        )
    }
    
    private static var peripheralAccessory: Accessory {
        return Accessory(
            name: "Cooler Accessory",
            description: "An accessory that's even more cool.",
            type: .peripheral,
            healthBonus: 10,
            armorPointsBonus: 20,
            buffs: [DamagePercentBuff(sourceName: "Cool Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)],
            equipmentPills: []
        )
    }
    
    // VIEW MODEL
    
    static var accessoryViewModel: AccessoryViewModel {
        return AccessoryViewModel(Self.accessory)
    }
    
    static var peripheralAccessoryViewModel: AccessoryViewModel {
        return AccessoryViewModel(Self.peripheralAccessory)
    }
    
    // MARK: - Loot
    
    // MODEL
    
    private static var lootBag: LootBag {
        let lootBag = LootBag()
        lootBag.addArmorLoot(self.armorViewModel.armor)
        lootBag.addPotionLoot(DamagePotion(tier: .II, potionCount: 3))
        lootBag.addAccessoryLoot(self.accessory)
        lootBag.addWeaponLoot(Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: InfiniteDurabilityPill(), effectPills: [LifestealEffectPill(lifestealFraction: 0.5)]))
        lootBag.addGoldLoot(100)
        return lootBag
    }
    
    private static var lootOptions: LootOptions {
        return LootOptions(self.lootBag, self.lootBag, self.lootBag)
    }
    
    // VIEW MODEL
    
    static var lootBagViewModel: LootBagViewModel {
        return LootBagViewModel(Self.lootBag)
    }
    
    static var lootOptionsViewModel: LootOptionsViewModel {
        return LootOptionsViewModel(Self.lootOptions)
    }
    
    // MARK: - NPCs
    
    // MODEL
    
    private static var foe: Foe {
        return Foe(
            contentID: nil,
            maxHealth: 500,
            weapon: Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)), loot: NoLootOptions()
        )
    }
    
    private static var goblin: GoblinFoe {
        return GoblinFoe(
            contentID: nil,
            name: "Sneaky Goblin",
            description: "He's so sneaky!",
            maxHealth: 24,
            goldPerSteal: 50,
            damage: 100,
            loot: NoLootOptions()
        )
    }
    
    private static var brute: BruteFoe {
        return BruteFoe(
            contentID: nil,
            name: "Massive Brute",
            description: "He's brutally obese.",
            maxHealth: 500,
            damage: 40,
            loot: NoLootOptions()
        )
    }
    
    private static var shopKeeper: ShopKeeper {
        return ShopKeeper(
            contentID: nil,
            name: "Andre",
            description: "I sell pancakes and maple syrup!!",
            purchasableItems: [
                PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 200), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50)), stock: 5),
                PurchasableItem(item: DamagePotion(tier: .II, potionCount: 2), stock: 2)
            ]
        )
    }
    
    private static var enhancer: Enhancer {
        return Enhancer(
            contentID: nil,
            name: "Ana",
            description: "You're powered up, get in there!",
            offers: [WeaponDamageEnhanceOffer(price: 100, damage: 200)]
        )
    }
    
    private static var restorer: Restorer {
        return Restorer(
            contentID: nil,
            name: "Mercy",
            description: "Heroes never die!",
            options: [.health, .armorPoints],
            pricePerHealthBundle: 10,
            pricePerArmorPointBundle: 10
        )
    }
    
    private static var friendly: Friendly {
        return Friendly(
            contentID: "N0004",
            name: "Winston",
            description: "With a Y",
            offers: [FreeGoldOffer(goldAmount: 200)],
            offerLimit: 1
        )
    }
    
    // VIEW MODEL
    
    static var foeViewModel: FoeViewModel {
        return FoeViewModel(Self.foe)
    }
    
    static var goblinViewModel: FoeViewModel {
        return FoeViewModel(Self.goblin)
    }
    
    static var bruteViewModel: FoeViewModel {
        return FoeViewModel(self.brute)
    }
    
    static var shopKeeperViewModel: ShopKeeperViewModel {
        return ShopKeeperViewModel(Self.shopKeeper)
    }
    
    static var enhancerViewModel: EnhancerViewModel {
        return EnhancerViewModel(Self.enhancer)
    }
    
    static var restorerViewModel: RestorerViewModel {
        return RestorerViewModel(Self.restorer)
    }
    
    static var friendlyViewModel: FriendlyViewModel {
        return FriendlyViewModel(Self.friendly)
    }
    
    // MARK: - NPC Extensions
    
    // MODEL
    
    private static var purchasableItem: PurchasableItem {
        return PurchasableItem(item: Self.armor, stock: 3)
    }
    
    private static var enhanceOffer: EnhanceOffer {
        return ArmorPointsEnhanceOffer(price: 100, armorPoints: 200)
    }
    
    // VIEW MODEL
    
    static var restoreOptionViewModel: RestoreOptionViewModel {
        return RestoreOptionViewModel(restoreOption: .health, restorerViewModel: Self.restorerViewModel)
    }
    
    static var purchasableViewModel: PurchasableViewModel {
        return PurchasableViewModel(
            purchasable: Self.purchasableItem,
            shopKeeperViewModel: ShopKeeperViewModel(ShopKeeper(
                contentID: nil,
                name: "Billy",
                description: "Sells things.",
                purchasableItems: [Self.purchasableItem])
            )
        )
    }
    
    static var enhanceOfferViewModel: EnhanceOfferViewModel {
        return EnhanceOfferViewModel(Self.enhanceOffer)
    }
    
    // MARK: - Items
    
    // MODEL
    
    private static var weapon: Weapon {
        return Weapon(
            basePill: DamageBasePill(damage: 200),
            durabilityPill: DecrementDurabilityPill(durability: 5)
        )
    }
    
    private static var potion: Potion {
        return DamagePotion(tier: .II, potionCount: 3)
    }
    
    // VIEW MODEL
    
    static var weaponViewModel: WeaponViewModel {
        return WeaponViewModel(Self.weapon)
    }
    
    static var potionViewModel: PotionViewModel {
        return PotionViewModel(Self.potion)
    }
    
    // MARK: - Consumables
    
    // MODEL
    
    private static var consumable: Consumable {
        return RipeningSetHealthConsumable(amount: 1)
    }
    
    // VIEW MODEL
    
    static var consumableViewModel: ConsumableViewModel {
        return ConsumableViewModel(Self.consumable)
    }
    
    // MARK: - Map
    
    // MODEL
    
    private static var area: Area {
        return Area(
            arrangement: .A,
            locations: Array(count: 19, populateWith: HostileLocation(foe: Foe(contentID: nil, maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions()))),
            name: "Glacier Rifts",
            description: "placeholderDescription",
            tags: RegionTagAllocation(tags: (.all, 1)),
            tileBackgroundImage: YonderImages.missingTileBackgroundImage,
            platformImage: YonderImages.missingPlatformImage
        )
    }
    
    private static var location: Location {
        let location = FriendlyLocation(friendly: Self.friendly)
        location.setAreaContext(Self.area)
        return location
    }
    
    private static var alternateLocation: Location {
        let location = HostileLocation(foe: Self.foe)
        location.setAreaContext(Self.area)
        return location
    }
    
    // VIEW MODEL
    
    static var locationViewModel: LocationViewModel {
        return LocationViewModel(Self.location)
    }
    
    static var alternateLocationViewModel: LocationViewModel {
        return LocationViewModel(Self.alternateLocation)
    }
    
}
