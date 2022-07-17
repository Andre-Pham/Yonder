//
//  PreviewObjects.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

enum PreviewObjects {
    
    // MARK: - Player
    
    static func playerViewModel() -> PlayerViewModel {
        let playerViewModel = PlayerViewModel(Player(
            maxHealth: 200,
            location: NoLocation()
        ))
        playerViewModel.player.equipArmor(
            ArmorAbstract(name: "Strong Armor", description: "So so strong.", type: .body, armorPoints: 200, basePurchasePrice: 200, armorBuffs: [DamagePercentBuff(sourceName: "Strong Armor", direction: .outgoing, duration: nil, damageFraction: 1.2)])
        )
        playerViewModel.player.addStatusEffect(BurnStatusEffect(damage: 12, duration: 5))
        playerViewModel.player.addStatusEffect(BurnStatusEffect(damage: 15, duration: 5))
        playerViewModel.player.addTimedEvent(MaxHealthRestorationTimedEvent(timeToTrigger: 5))
        playerViewModel.player.equipAccessory(Accessory(name: "Scarf", description: "A warm wooly scarf to keep you warm.", type: .regular, healthBonus: 100, armorPointsBonus: 0, basePurchasePrice: 25, buffs: []), replacing: nil)
        return playerViewModel
    }
    
    static let armorViewModel = ArmorViewModel(ResistanceArmor(
        name: "Cool Resistance Armor",
        description: "Very Shiny.",
        type: .body,
        armorPoints: 500,
        damageFraction: 0.8,
        basePurchasePrice: 200
    ))
    
    static let accessoryViewModel = AccessoryViewModel(Accessory(
        name: "Cool Accessory",
        description: "An accessory that's so very cool.",
        type: .regular,
        healthBonus: 0,
        armorPointsBonus: 0,
        basePurchasePrice: 0,
        buffs: [DamagePercentBuff(sourceName: "Cool Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)]
    ))
    
    static let peripheralAccessoryViewModel = AccessoryViewModel(Accessory(
        name: "Cooler Accessory",
        description: "An accessory that's even more cool.",
        type: .peripheral,
        healthBonus: 10,
        armorPointsBonus: 20,
        basePurchasePrice: 100,
        buffs: [DamagePercentBuff(sourceName: "Cool Accessory", direction: .outgoing, duration: nil, damageFraction: 1.5)]
    ))
    
    // MARK: - Loot
    
    static var lootBagViewModel: LootBagViewModel {
        let lootBag = LootBag()
        lootBag.addArmorLoot(self.armorViewModel.armor)
        lootBag.addPotionLoot(DamagePotion(tier: .II, potionCount: 3, basePurchasePrice: 200))
        lootBag.addAccessoryLoot(self.accessoryViewModel.accessory)
        lootBag.addWeaponLoot(Weapon(basePill: LifestealBasePill(damage: 100), durabilityPill: InfiniteDurabilityPill()))
        lootBag.addGoldLoot(100)
        return LootBagViewModel(lootBag)
    }
    
    static var lootOptionsViewModel: LootOptionsViewModel {
        return LootOptionsViewModel(LootOptions(self.lootBagViewModel.lootBag, self.lootBagViewModel.lootBag, self.lootBagViewModel.lootBag))
    }
    
    // MARK: - NPCs
    
    static let foeViewModel = FoeViewModel(Foe(
        maxHealth: 500,
        weapon: Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)), loot: NoLootOptions()
    ))
    
    static let shopKeeperViewModel = ShopKeeperViewModel(ShopKeeper(
        name: "Andre",
        description: "I sell pancakes and maple syrup!!",
        purchasableItems: [
            PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 200), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50)), stock: 5)
        ]
    ))
    
    static let enhancerViewModel = EnhancerViewModel(Enhancer(
        name: "Ana",
        description: "You're powered up, get in there!",
        offers: [WeaponDamageEnhanceOffer(price: 100, damage: 200)]
    ))
    
    static let restorerViewModel = RestorerViewModel(Restorer(
        name: "Mercy",
        description: "Heroes never die!",
        options: [.health, .armorPoints],
        pricePerHealthBundle: 10,
        pricePerArmorPointBundle: 10
    ))
    
    static let friendlyViewModel = FriendlyViewModel(Friendly(
        name: "Winston",
        description: "With a Y",
        offers: [FreeGoldOffer(goldAmount: 200)],
        offerLimit: 1
    ))
    
    // MARK: - NPC Extensions
    
    static let restoreOptionViewModel = RestoreOptionViewModel(
        restoreOption: .health,
        restorerViewModel: RestorerViewModel(Restorer(options: [.health]))
    )
    
    static let purchasableViewModel = PurchasableViewModel(
        purchasable: PurchasableItem(
            item: ArmorAbstract(
                name: "Cool Armor",
                description: "Very cool.",
                type: .body,
                armorPoints: 200,
                basePurchasePrice: 100,
                armorBuffs: []
            ),
            stock: 3
        ),
        shopKeeperViewModel: ShopKeeperViewModel(ShopKeeper(
            name: "ShopKeeper",
            description: "Sells things.",
            purchasableItems: []
        ))
    )
    
    static let enhanceOfferViewModel = EnhanceOfferViewModel(
        ArmorPointsEnhanceOffer(price: 100, armorPoints: 200)
    )
    
    // MARK: - Items
    
    static let weaponViewModel = WeaponViewModel(Weapon(
        basePill: DamageBasePill(damage: 200),
        durabilityPill: DecrementDurabilityPill(durability: 5)
    ))
    
    static let potionViewModel = PotionViewModel(DamagePotion(tier: .II, potionCount: 3, basePurchasePrice: 100))
    
    // MARK: - Map
    
    private static let area = Area(
        arrangement: .A,
        locations: [
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions())),
            HostileLocation(foe: Foe(maxHealth: 200, weapon: BaseAttack(damage: 100), loot: NoLootOptions()))
        ],
        name: "Glacier Rifts",
        description: "placeholderDescription",
        image: YonderImages.placeholderImage
    )
    
    static func locationViewModel() -> LocationViewModel {
        let location = FriendlyLocation(friendly: Friendly(name: "Billy", description: "Likes rainy days.", offers: [], offerLimit: 0))
        location.setAreaContent(PreviewObjects.area)
        return LocationViewModel(location)
    }
    
    static func alternateLocationViewModel() -> LocationViewModel {
        let location = FriendlyLocation(friendly: Friendly(name: "Bob", description: "Hates Billy.", offers: [], offerLimit: 0))
        location.setAreaContent(PreviewObjects.area)
        return LocationViewModel(location)
    }
    
}
