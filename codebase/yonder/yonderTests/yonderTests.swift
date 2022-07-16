//
//  yonderTests.swift
//  yonderTests
//
//  Created by Andre Pham on 17/11/21.
//

import XCTest
@testable import yonder

class yonderTests: XCTestCase {

    func testActorHealth() throws {
        let actor = ActorAbstract(maxHealth: 250)
        actor.damage(for: 50)
        XCTAssertEqual(actor.health, 200)
        actor.restoreHealth(for: 500)
        XCTAssertEqual(actor.health, actor.maxHealth)
    }
    
    func testAttack() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let foe = Foe(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.useWeaponWhere(opposition: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 195)
    }
    
    func testDeath() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.damage(for: 150)
        XCTAssertTrue(!player.isDead)
        player.damage(for: 150)
        XCTAssertTrue(player.isDead)
    }
    
    func testStatusEffects() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.addStatusEffect(BurnStatusEffect(damage: 5, duration: 5))
        player.triggerStatusEffects()
        XCTAssertTrue(player.health == 195)
    }
    
    func testTimedEvents() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.damage(for: 150)
        let timedEvent = MaxHealthRestorationTimedEvent(timeToTrigger: 2)
        player.addTimedEvent(timedEvent)
        player.decrementTimedEvents()
        XCTAssertTrue(player.health == 50)
        XCTAssertTrue(player.timedEvents.count == 1)
        player.decrementTimedEvents()
        XCTAssertTrue(player.health == 200)
        XCTAssertTrue(player.timedEvents.count == 0)
    }
    
    func testBuffs() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let foe = Foe(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.addBuff(DamagePercentBuff(sourceName: "testBuffs", direction: .outgoing, duration: 5, damageFraction: 2.0))
        foe.addBuff(DamagePercentBuff(sourceName: "testBuffs", direction: .outgoing, duration: 5, damageFraction: 2.0))
        foe.useWeaponWhere(opposition: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 180)
    }
    
    func testBuffPriority() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let foe = Foe(maxHealth: 200, weapon: BaseAttack(damage: 25))
        foe.addBuff(DamagePercentBuff(sourceName: "testBuffPriority", direction: .outgoing, duration: 5, damageFraction: 2.0))
        foe.addBuff(DamageBuff(sourceName: "testBuffPriority", direction: .outgoing, duration: 5, damageDifference: 5))
        foe.addBuff(DamagePercentBuff(sourceName: "testBuffPriority", direction: .outgoing, duration: 5, damageFraction: 2.0))
        foe.useWeaponWhere(opposition: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 80)
    }
    
    func testArmor() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.equipArmor(Armors.newTestBodyArmor())
        let foe = Foe(maxHealth: 200, weapon: BaseAttack(damage: 100))
        foe.useWeaponWhere(opposition: player, weapon: foe.getWeapon())
        print(player.health)
        XCTAssertTrue(player.armorPoints == player.headArmor.armorPoints + player.bodyArmor.armorPoints - 64)
    }
    
    func testHealingWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.addWeapon(Weapon(basePill: HealthRestorationBasePill(healthRestoration: 50), durabilityPill: InfiniteDurabilityPill()))
        player.damage(for: 100)
        player.useWeaponWhere(opposition: player, weapon: player.weapons.first!)
        XCTAssertTrue(player.health == 150)
    }
    
    func testDullingWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let weapon = Weapon(basePill: DamageBasePill(damage: 7), durabilityPill: DullingDurabilityPill(damageLostPerUse: 2))
        player.addWeapon(weapon)
        let playerWeapon = player.weapons.first! // Adding a weapon clones it
        let foe = Foe(maxHealth: 200, weapon: Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: InfiniteDurabilityPill()))
        player.useWeaponWhere(opposition: foe, weapon: playerWeapon)
        player.useWeaponWhere(opposition: foe, weapon: playerWeapon)
        player.useWeaponWhere(opposition: foe, weapon: playerWeapon)
        XCTAssertTrue(playerWeapon.damage == 1)
        XCTAssertTrue(playerWeapon.remainingUses != 0)
        player.useWeaponWhere(opposition: foe, weapon: playerWeapon)
        XCTAssertTrue(playerWeapon.remainingUses == 0)
        XCTAssertTrue(foe.health == 200 - 7 - 5 - 3 - 1)
    }
    
    func testRestore() throws {
        var player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.damage(for: 250)
        XCTAssertEqual(player.health, 150)
        XCTAssertEqual(player.armorPoints, 0)
        player.restore(for: 100)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 50)
        player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.damage(for: 300)
        player.restore(for: 50)
        XCTAssertEqual(player.health, 150)
        XCTAssertEqual(player.armorPoints, 0)
    }
    
    func testPotion() throws {
        var player = Player(maxHealth: 200, location: NoLocation())
        player.damage(for: 100)
        player.addPotion(HealthRestorationPotion(tier: .II, potionCount: 1, basePurchasePrice: 0))
        player.potions.first!.use(owner: player, opposition: player)
        XCTAssertEqual(player.health, 150)
        player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.damage(for: 350)
        player.addPotion(MaxRestorationPotion(potionCount: 1, basePurchasePrice: 0))
        player.potions.first!.use(owner: player, opposition: player)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 200)
    }
    
    func testRemoveWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let weapon = Weapon(basePill: DamageBasePill(damage: 5), durabilityPill: DecrementDurabilityPill(durability: 2))
        player.addWeapon(weapon)
        let playerWeapon = player.weapons.first! // Adding a weapon clones it
        player.useWeaponWhere(opposition: player, weapon: playerWeapon)
        XCTAssertEqual(player.weapons.count, 1)
        player.useWeaponWhere(opposition: player, weapon: playerWeapon)
        XCTAssertEqual(player.weapons.count, 0)
    }
    
    func testIDs() throws {
        let weapon1 = Weapon(basePill: DamageBasePill(damage: 5), durabilityPill: DecrementDurabilityPill(durability: 2))
        let weapon2 = Weapon(basePill: DamageBasePill(damage: 5), durabilityPill: DecrementDurabilityPill(durability: 2))
        let weapon3 = Weapon(basePill: DamageBasePill(damage: 4), durabilityPill: DecrementDurabilityPill(durability: 2))
        XCTAssertTrue(weapon1.id != weapon2.id && weapon2.id != weapon3.id && weapon1.id != weapon3.id)
    }
    
    func testSubscriber() throws {
        let weapon = Weapon(basePill: LifestealBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
        XCTAssert(weapon.damage == 50)
        XCTAssert(weapon.healthRestoration == 50)
        weapon.setDamage(to: 100)
        XCTAssert(weapon.damage == 100)
        XCTAssert(weapon.healthRestoration == 100)
    }
    
    func testStackable() throws {
        let potion1 = DamagePotion(tier: .I, potionCount: 5, basePurchasePrice: 5)
        let potion2 = DamagePotion(tier: .I, potionCount: 1, basePurchasePrice: 1)
        let potion3 = HealthRestorationPotion(tier: .I, potionCount: 5, basePurchasePrice: 5)
        let potion4 = DamagePotion(tier: .II, potionCount: 1, basePurchasePrice: 1)
        XCTAssertTrue(potion1.isStackable(with: potion2))
        XCTAssertTrue(potion2.isStackable(with: potion1))
        XCTAssertFalse(potion1.isStackable(with: potion3))
        XCTAssertFalse(potion1.isStackable(with: potion4))
    }
    
    func testLocationCasting() throws {
        let location = LocationAbstractPart()
        let combatLocation = HostileLocation(foe: Foe(maxHealth: 200, weapon: Weapon(basePill: DamageBasePill(damage: 4), durabilityPill: DecrementDurabilityPill(durability: 2))))
        location.addNextLocations([combatLocation])
        XCTAssertNoThrow((location.nextLocations.first! as! HostileLocation).foe)
        // Normally you'd only cast after you check that the location is of LocationType .hostile
        // let foe = (location.nextLocations.first! as! HostileLocation).foe
    }
    
    func testPurchasing() throws {
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: HealthRestorationPotion(tier: .IV, potionCount: 1, basePurchasePrice: 200), stock: 1),
            PurchasableItem(item: ResistanceArmor(type: .body, armorPoints: 200, damageFraction: 0.8, basePurchasePrice: 100), stock: 1)
        ])
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 1000)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 800)
        XCTAssertEqual(player.potions.count, 1)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 700)
        XCTAssertTrue(player.bodyArmor is ResistanceArmor)
    }
    
    func testPotionBuff() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.addBuff(PotionDamagePercentBuff(sourceName: "testPotionBuff", direction: .outgoing, duration: 5, damageFraction: 2.0))
        let foe = Foe(maxHealth: 200, weapon: Weapon(basePill: DamageBasePill(damage: 10), durabilityPill: DecrementDurabilityPill(durability: 5)))
        let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5))
        let potion = DamagePotion(tier: .II, potionCount: 1, basePurchasePrice: 0)
        player.addWeapon(weapon)
        player.addPotion(potion)
        player.useWeaponWhere(opposition: foe, weapon: weapon)
        XCTAssertEqual(foe.health, 150)
        player.usePotionWhere(opposition: foe, potion: potion)
        XCTAssertEqual(foe.health, 50)
    }
    
    func testRestoreAdjusted() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestBodyArmor()) // 200 armorPoints
        player.damage(for: 300)
        player.addBuff(HealthRestorationPercentBuff(sourceName: "testRestoreAdjusted", direction: .incoming, duration: 1, healthFraction: 2.0))
        player.addBuff(ArmorPointsRestorationPercentBuff(sourceName: "testRestoreAdjusted", direction: .incoming, duration: 1, armorPointsFraction: 0.5))
        player.restoreAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 100)
        // The first 50 restoration heals them back to full health (+100 health)
        // The next 50 are only 50% effective (+25 armor)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 25)
    }
    
    func testShopKeeper() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 200)
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: DamagePotion(tier: .III, potionCount: 2, basePurchasePrice: 50), stock: 2)
        ])
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 150)
        XCTAssertEqual(player.potions.count, 1)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 1)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 100)
        XCTAssertEqual(player.potions.map { $0.potionCount }.reduce(0, +), 4)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 0)
    }
    
    func testEnhancer() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 201)
        let weapon = Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DecrementDurabilityPill(durability: 5))
        player.addWeapon(weapon)
        let enhancer = Enhancer(offers: [WeaponDamageEnhanceOffer(price: 200, damage: 50)])
        enhancer.enhanceOffers.first?.acceptOffer(player: player, enhanceableID: player.weapons.first!.id)
        XCTAssertEqual(player.gold, 1)
        XCTAssertEqual(player.weapons.first!.damage, 150)
    }
    
    func testRestorer() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 200)
        player.damage(for: 150)
        let restorer = Restorer(options: [.health], pricePerHealthBundle: 5)
        restorer.restoreHealth(to: player, amount: 20)
        XCTAssertEqual(player.health, 70)
        XCTAssertEqual(player.gold, 200 - 5*20/Restorer.bundleSize)
    }
    
    func testFriendly() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let friendly = Friendly(
            offers: [FreeGoldOffer(goldAmount: 500), FreeGoldOffer(goldAmount: 100), FreeGoldOffer(goldAmount: 1)],
            offerLimit: 2)
        friendly.acceptOffer(friendly.offers[0], for: player)
        XCTAssertEqual(player.gold, 500)
        XCTAssertEqual(friendly.offers.count, 2)
        friendly.acceptOffer(friendly.offers[0], for: player)
        XCTAssertEqual(player.gold, 600)
        XCTAssertEqual(friendly.offers.count, 0)
    }

}
