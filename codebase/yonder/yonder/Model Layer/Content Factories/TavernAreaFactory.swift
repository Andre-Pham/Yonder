//
//  TavernAreaFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class TavernAreaFactory {
    
    private let factoryBundle: AreaFactoryBundle
    private let stage: Int
    
    init(stage: Int, factoryBundle: AreaFactoryBundle) {
        self.stage = stage
        self.factoryBundle = factoryBundle
    }
    
    func deliver() -> TavernArea {
        let outcome = TavernAreaArrangements.allCases.randomElement()!
        let restorer = Restorers.newRestorer(
            profile: RestorerProfile(
                restorerName: Strings("restorer.tavern.name").local,
                restorerDescription: Strings("restorer.tavern.description").local,
                areaTags: [],
                restoreOptions: []
            ),
            stage: self.stage,
            restoreOptions: [.health, .armorPoints]
        )
        let potionsShopKeeper = ShopKeeper(
            name: Strings("shopKeeper.tavern.name").local,
            description: Strings("shopKeeper.tavern.description").local,
            purchasableItems: [
                PurchasableItem(item: HealthRestorationPotion(tier: .III, potionCount: 3), stock: 5, priceAdjustment: 1.0),
                PurchasableItem(item: RestoreArmorPointsConsumable(tier: .III, amount: 3), stock: 5, priceAdjustment: 1.0),
                PurchasableItem(item: DamagePotion(tier: .III, potionCount: 3), stock: 5, priceAdjustment: 1.0)
            ])
        let npcFactory = self.factoryBundle.interactorFactories
        switch outcome {
        case .S:
            return TavernArea(
                restorer: RestorerLocation(restorer: restorer),
                potionShop: ShopLocation(shopKeeper: potionsShopKeeper),
                enhancer: EnhancerLocation(enhancer: npcFactory.enhancerFactory.deliver())
            )
        case .M:
            return TavernArea(
                restorer: RestorerLocation(restorer: restorer),
                potionShop: ShopLocation(shopKeeper: potionsShopKeeper),
                enhancer: EnhancerLocation(enhancer: npcFactory.enhancerFactory.deliver()),
                otherShop: ShopLocation(shopKeeper: npcFactory.shopKeeperFactory.deliver())
            )
        case .L:
            return TavernArea(
                restorer: RestorerLocation(restorer: restorer),
                potionShop: ShopLocation(shopKeeper: potionsShopKeeper),
                enhancer: EnhancerLocation(enhancer: npcFactory.enhancerFactory.deliver()),
                otherShop: ShopLocation(shopKeeper: npcFactory.shopKeeperFactory.deliver()),
                friendly: FriendlyLocation(friendly: npcFactory.friendlyFactory.deliver())
            )
        case .XL:
            return TavernArea(
                restorer: RestorerLocation(restorer: restorer),
                potionShop: ShopLocation(shopKeeper: potionsShopKeeper),
                enhancer: EnhancerLocation(enhancer: npcFactory.enhancerFactory.deliver()),
                otherShop: ShopLocation(shopKeeper: npcFactory.shopKeeperFactory.deliver()),
                friendly: FriendlyLocation(friendly: npcFactory.friendlyFactory.deliver()),
                secondFriendly: FriendlyLocation(friendly: npcFactory.friendlyFactory.deliver())
            )
        }
    }
    
}
