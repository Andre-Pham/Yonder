//
//  ShopKeeperFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperFactory {
    
    private let lootFactories: LootFactoryBundle
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let shopKeeperProfileBucket: ShopKeeperProfileBucket
    
    init(stage: Int, regionTags: RegionTagAllocation, shopKeeperBucket: ShopKeeperProfileBucket, lootFactories: LootFactoryBundle) {
        self.stage = stage
        self.regionTags = regionTags
        self.shopKeeperProfileBucket = shopKeeperBucket
        self.lootFactories = lootFactories
    }
    
    private func buildShopKeeper(stage: Int, tags: RegionTagAllocation) -> ShopKeeper {
        let profile = self.shopKeeperProfileBucket.grabProfile(areaTag: tags.getTag())
        var purchasableItems = [PurchasableItem]()
        let purchasableItemCount = Int.random(in: 2...5)
        for _ in 0..<purchasableItemCount {
            let toAdd = PurchasableItem.PurchasableItemType.allCases.randomElement()!
            switch toAdd {
            case .weapon:
                let stock = Int.random(in: 1...3)
                purchasableItems.append(PurchasableItem(item: self.lootFactories.weaponFactory.deliver(), stock: stock))
            case .potion:
                let stock = Int.random(in: 1...3)
                purchasableItems.append(PurchasableItem(item: self.lootFactories.potionFactory.deliver(), stock: stock))
            case .armor:
                purchasableItems.append(PurchasableItem(item: self.lootFactories.armorFactory.deliver(), stock: 1))
            case .accessory:
                purchasableItems.append(PurchasableItem(item: self.lootFactories.accessoryFactory.deliver(), stock: 1))
            case .consumable:
                let stock = Int.random(in: 1...3)
                purchasableItems.append(PurchasableItem(item: self.lootFactories.consumableFactory.deliver(), stock: stock))
            }
        }
        return ShopKeeper(
            name: profile.shopKeeperName,
            description: profile.shopKeeperDescription,
            purchasableItems: purchasableItems
        )
    }
    
    func deliver() -> ShopKeeper {
        return self.buildShopKeeper(stage: self.stage, tags: self.regionTags)
    }
    
    func deliver(count: Int) -> [ShopKeeper] {
        var shopKeepers = [ShopKeeper]()
        shopKeepers.populate(count: count) {
            self.buildShopKeeper(stage: self.stage, tags: self.regionTags)
        }
        return shopKeepers
    }
    
}
