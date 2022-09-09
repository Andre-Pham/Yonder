//
//  InteractorTests.swift
//  ModelTests
//
//  Created by Andre Pham on 9/9/2022.
//

import XCTest
@testable import yonder

class InteractorTests: XCTestCase {
    
    let player = Player(maxHealth: 200, location: NoLocation())

    func testPurchasing() throws {
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: HealthRestorationPotion(tier: .IV, potionCount: 1, basePurchasePrice: 200), stock: 1),
            PurchasableItem(item: Armor(name: "Cool Armor", description: "Cool.", type: .body, armorPoints: 200, basePurchasePrice: 100, armorBuffs: [], equipmentPills: []), stock: 1)
        ])
        self.player.modifyGold(by: 1000)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: self.player)
        XCTAssertEqual(self.player.gold, 800)
        XCTAssertEqual(self.player.potions.count, 1)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: self.player)
        XCTAssertEqual(self.player.gold, 700)
        XCTAssertTrue(self.player.bodyArmor.armorPoints == 200)
    }
    
    func testRestoreAdjusted() throws {
        self.player.equipArmor(Armors.newTestBodyArmor()) // 200 armorPoints
        self.player.damage(for: 300)
        self.player.addBuff(HealthRestorationPercentBuff(sourceName: "testRestoreAdjusted", direction: .incoming, duration: 1, healthFraction: 2.0))
        self.player.addBuff(ArmorPointsRestorationPercentBuff(sourceName: "testRestoreAdjusted", direction: .incoming, duration: 1, armorPointsFraction: 0.5))
        self.player.restoreAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 100)
        // The first 50 restoration heals them back to full health (+100 health)
        // The next 50 are only 50% effective (+25 armor)
        XCTAssertEqual(self.player.health, 200)
        XCTAssertEqual(self.player.armorPoints, 25)
    }
    
    func testShopKeeper() throws {
        self.player.modifyGold(by: 200)
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: DamagePotion(tier: .III, potionCount: 2, basePurchasePrice: 50), stock: 2)
        ])
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: self.player)
        XCTAssertEqual(self.player.gold, 150)
        XCTAssertEqual(self.player.potions.count, 1)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 1)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: self.player)
        XCTAssertEqual(self.player.gold, 100)
        XCTAssertEqual(self.player.potions.map { $0.potionCount }.reduce(0, +), 4)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 0)
    }
    
    func testEnhancer() throws {
        self.player.modifyGold(by: 201)
        let weapon = Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DecrementDurabilityPill(durability: 5))
        self.player.addWeapon(weapon)
        let enhancer = Enhancer(offers: [WeaponDamageEnhanceOffer(price: 200, damage: 50)])
        enhancer.enhanceOffers.first?.acceptOffer(player: self.player, enhanceableID: self.player.weapons.first!.id)
        XCTAssertEqual(self.player.gold, 1)
        XCTAssertEqual(self.player.weapons.first!.damage, 150)
    }
    
    func testRestorer() throws {
        self.player.modifyGold(by: 200)
        self.player.damage(for: 150)
        let restorer = Restorer(options: [.health], pricePerHealthBundle: 5)
        restorer.restoreHealth(to: self.player, amount: 20)
        XCTAssertEqual(self.player.health, 70)
        XCTAssertEqual(self.player.gold, 200 - 5*20/Restorer.bundleSize)
    }
    
    func testFriendly() throws {
        let friendly = Friendly(
            offers: [FreeGoldOffer(goldAmount: 500), FreeGoldOffer(goldAmount: 100), FreeGoldOffer(goldAmount: 1)],
            offerLimit: 2)
        friendly.acceptOffer(friendly.offers[0], for: self.player)
        XCTAssertEqual(self.player.gold, 500)
        XCTAssertEqual(friendly.offers.count, 2)
        friendly.acceptOffer(friendly.offers[0], for: self.player)
        XCTAssertEqual(self.player.gold, 600)
        XCTAssertEqual(friendly.offers.count, 0)
    }

}
