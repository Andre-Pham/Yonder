//
//  TavernAreaFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class TavernAreaFactory {
    
    private let areaProfile: RegionProfile
    private let stage: Int
    
    init(areaProfile: RegionProfile, stage: Int) {
        self.areaProfile = areaProfile
        self.stage = stage
    }
    
    func deliver() -> TavernArea {
        let outcome = TavernAreaArrangement.allCases.randomElement()!
        // No profiles (no content IDs) - this means it's generated on-demand when the player visits the location
        let restorer = Restorers.newRestorerNoProfile(
            stage: self.stage,
            restoreOptions: [.health, .armorPoints]
        )
        let potionsShopKeeper = ShopKeeper(
            contentID: nil,
            name: "",
            description: "",
            purchasableItems: [
                PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 2), stock: 3, priceAdjustment: 1.0),
                PurchasableItem(item: RestoreArmorPointsConsumable(tier: .III, amount: 2), stock: 3, priceAdjustment: 1.0),
                // Note: price adjustment is 2x for the damage potions because they're extra strong against bosses
                PurchasableItem(item: DamagePotion(tier: .III, potionCount: 2), stock: 2, priceAdjustment: 2.0)
            ]
        )
        switch outcome {
        case .tiny:
            // If the tavern area is of type "tiny", there are 2 locations
            // The first is a restorer location (default as first location for all tavern areas - player should heal before taking on the boss)
            // Second is either a shop location or enhancer location (acts as a money sink, and lets the player spend/prep before fighting the boss)
            var spendingLocation: Location
            if Random.roll(1, in: 2) {
                spendingLocation = ShopLocation()
            } else {
                spendingLocation = EnhancerLocation()
            }
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                tileBackgroundImage: self.areaProfile.regionTileBackgroundImage,
                platformImage: self.areaProfile.regionPlatformImage,
                RestorerLocation(restorer: restorer),
                spendingLocation
            )
        case .small:
            // If the tavern area is of type "small", there are 3 locations
            // The first is a restorer location (default as first location for all tavern areas - player should heal before taking on the boss)
            // Second is a friendly location (two spending locations would give too much choice)
            // NOTE: Second should be the friendly (not the shop/enhancer) because friendlies can require or give gold which affects spending at the next location (being a shop/enhancer)
            // Third is either a potion shop location or enhancer location (acts as a money sink, and lets the player spend/prep before fighting the boss)
            // IMPORTANT DIFFERENTIATOR: since this tavern area ALSO has a friendly (second) location, the shop location only can sell potions
            var spendingLocation: Location
            if Random.roll(1, in: 2) {
                spendingLocation = ShopLocation(shopKeeper: potionsShopKeeper)
            } else {
                spendingLocation = EnhancerLocation()
            }
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                tileBackgroundImage: self.areaProfile.regionTileBackgroundImage,
                platformImage: self.areaProfile.regionPlatformImage,
                RestorerLocation(restorer: restorer),
                FriendlyLocation(),
                spendingLocation
            )
        }
    }
    
}
