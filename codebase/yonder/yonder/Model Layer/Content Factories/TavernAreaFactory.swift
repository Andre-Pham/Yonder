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
        let outcome = TavernAreaArrangements.allCases.randomElement()!
        let restorer = Restorers.newRestorer(
            profile: RestorerProfile(
                id: "", // TODO: Fix this (otherwise visiting a tavern area will throw an error because the file won't be found)
                restorerName: Strings("restorer.tavern.name").local,
                restorerDescription: Strings("restorer.tavern.description").local,
                regionTags: [],
                restoreOptions: []
            ),
            stage: self.stage,
            restoreOptions: [.health, .armorPoints]
        )
        let potionsShopKeeper = ShopKeeper(
            contentID: nil, // TODO: Add content id
            name: Strings("shopKeeper.tavern.name").local,
            description: Strings("shopKeeper.tavern.description").local,
            purchasableItems: [
                PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 3), stock: 5, priceAdjustment: 1.0),
                PurchasableItem(item: RestoreArmorPointsConsumable(tier: .III, amount: 3), stock: 5, priceAdjustment: 1.0),
                PurchasableItem(item: DamagePotion(tier: .III, potionCount: 3), stock: 5, priceAdjustment: 1.0)
            ]
        )
        switch outcome {
        case .S:
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                background: self.areaProfile.regionBackground,
                foreground: self.areaProfile.regionForeground,
                RestorerLocation(restorer: restorer),
                ShopLocation(shopKeeper: potionsShopKeeper),
                EnhancerLocation()
            )
        case .M:
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                background: self.areaProfile.regionBackground,
                foreground: self.areaProfile.regionForeground,
                RestorerLocation(restorer: restorer),
                ShopLocation(shopKeeper: potionsShopKeeper),
                EnhancerLocation(),
                ShopLocation()
            )
        case .L:
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                background: self.areaProfile.regionBackground,
                foreground: self.areaProfile.regionForeground,
                RestorerLocation(restorer: restorer),
                ShopLocation(shopKeeper: potionsShopKeeper),
                EnhancerLocation(),
                ShopLocation(),
                FriendlyLocation()
            )
        case .XL:
            return TavernArea(
                name: self.areaProfile.regionName,
                description: self.areaProfile.regionDescription,
                tags: self.areaProfile.tags,
                background: self.areaProfile.regionBackground,
                foreground: self.areaProfile.regionForeground,
                RestorerLocation(restorer: restorer),
                ShopLocation(shopKeeper: potionsShopKeeper),
                EnhancerLocation(),
                ShopLocation(),
                FriendlyLocation(),
                FriendlyLocation()
            )
        }
    }
    
}
