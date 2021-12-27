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
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
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
        player.addStatusEffect(BurnStatusEffect(damage: 5))
        player.triggerStatusEffects()
        XCTAssertTrue(player.health == 195)
    }
    
    func testTimedEvents() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.damage(for: 150)
        let timedEvent = FullHealTimedEvent(timeToTrigger: 2, target: player)
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
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 180)
    }
    
    func testBuffPriority() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 25))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.addBuff(DamageBuff(duration: 5, damageDifference: 5))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 80)
    }
    
    func testArmor() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.equipArmor(Armors.newTestBodyArmor())
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 100))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        print(player.health)
        XCTAssertTrue(player.armorPoints == player.headArmor.armorPoints + player.bodyArmor.armorPoints - 64)
    }
    
    func testHealingWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.addWeapon(HealthRestorationWeapon(healthRestoration: 50, durability: 2, basePurchasePrice: 0))
        player.damage(for: 100)
        player.useWeaponOn(target: player, weapon: player.weapons.first!)
        XCTAssertTrue(player.health == 150)
    }
    
    func testDullingWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let weapon = DullingWeapon(damage: 7, damageLostPerUse: 2, basePurchasePrice: 0)
        player.addWeapon(weapon)
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 100))
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        XCTAssertTrue(player.weapons.first!.damage == 1)
        XCTAssertTrue(player.weapons.first!.remainingUses == 1)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        XCTAssertTrue(weapon.remainingUses == 0)
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
        player.addPotion(HealthRestorationPotion(healthRestoration: 50, potionCount: 1, basePurchasePrice: 0))
        player.potions.first!.use(owner: player, target: player)
        XCTAssertEqual(player.health, 150)
        player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestHeadArmor())
        player.damage(for: 350)
        player.addPotion(FullRestorationPotion(potionCount: 1, basePurchasePrice: 0))
        player.potions.first!.use(owner: player, target: player)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 200)
    }
    
    func testRemoveWeapon() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        let weapon = BasicWeapon(damage: 5, durability: 2, basePurchasePrice: 0)
        player.addWeapon(weapon)
        player.useWeaponOn(target: player, weapon: weapon)
        XCTAssertEqual(player.weapons.count, 1)
        player.useWeaponOn(target: player, weapon: weapon)
        XCTAssertEqual(player.weapons.count, 0)
    }
    
    func testIDs() throws {
        let weapon1 = BasicWeapon(damage: 5, durability: 2, basePurchasePrice: 0)
        let weapon2 = BasicWeapon(damage: 5, durability: 2, basePurchasePrice: 0)
        let weapon3 = BasicWeapon(damage: 4, durability: 2, basePurchasePrice: 0)
        XCTAssertTrue(weapon1.id != weapon2.id && weapon2.id != weapon3.id && weapon1.id != weapon3.id)
        let weapon4 = BaseAttack(damage: 5)
        XCTAssertNotEqual(weapon1.getSharedID(), weapon4.getSharedID())
        XCTAssertEqual(weapon1.getSharedID(), weapon2.getSharedID())
    }
    
    func testLocationCasting() throws {
        let location = LocationAbstractPart()
        let combatLocation = HostileLocation(foe: FoeAbstract(maxHealth: 200, weapon: Weapons.newTestBasicWeapon()))
        location.addNextLocations([combatLocation])
        XCTAssertNoThrow((location.nextLocations.first! as! HostileLocation).foe)
        // Normally you'd only cast after you check that the location is of LocationType .hostile
        // let foe = (location.nextLocations.first! as! HostileLocation).foe
    }
    
    func testPurchasing() throws {
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: BasicWeapon(damage: 200, durability: 5, basePurchasePrice: 300), stock: 2),
            PurchasableItem(item: HealthRestorationPotion(healthRestoration: 200, potionCount: 1, basePurchasePrice: 200), stock: 1),
            PurchasableItem(item: ResistanceArmor(type: .body, armorPoints: 200, damageFraction: 0.8, basePurchasePrice: 100), stock: 1)
        ])
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 1000)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 700)
        XCTAssertEqual(player.weapons.count, 1)
        shopKeeper.purchaseItem(at: 1, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 500)
        XCTAssertEqual(player.potions.count, 1)
        shopKeeper.purchaseItem(at: 1, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 400)
        XCTAssertTrue(player.bodyArmor is ResistanceArmor)
    }
    
    func testPotionBuff() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.addBuff(PotionDamagePercentBuff(duration: 5, damageFraction: 2.0))
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 10))
        let weapon = BaseAttack(damage: 50)
        let potion = DamagePotion(damage: 50, potionCount: 1, basePurchasePrice: 0)
        player.addWeapon(weapon)
        player.addPotion(potion)
        player.useWeaponOn(target: foe, weapon: weapon)
        XCTAssertEqual(foe.health, 150)
        player.use(potion, on: foe)
        XCTAssertEqual(foe.health, 50)
    }
    
    func testRestoreAdjusted() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.equipArmor(Armors.newTestBodyArmor()) // 200 armorPoints
        player.damage(for: 300)
        player.addBuff(HealthRestorationPercentBuff(duration: 1, healthFraction: 2.0))
        player.addBuff(ArmorPointsRestorationPercentBuff(duration: 1, armorPointsFraction: 0.5))
        player.restoreAdjusted(sourceOwner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, for: 100)
        // The first 50 restoration heals them back to full health (+100 health)
        // The next 50 are only 50% effective (+25 armor)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 25)
    }
    
    func testShopKeeper() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 200)
        let shopKeeper = ShopKeeper(purchasableItems: [
            PurchasableItem(item: DullingWeapon(damage: 100, damageLostPerUse: 10, basePurchasePrice: 50), stock: 2)
        ])
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 150)
        XCTAssertEqual(player.weapons.count, 1)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 1)
        shopKeeper.purchaseItem(at: 0, amount: 1, purchaser: player)
        XCTAssertEqual(player.gold, 100)
        XCTAssertEqual(player.weapons.count, 2)
        XCTAssertEqual(shopKeeper.purchasableItems.count, 0)
    }
    
    func testEnhancer() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 201)
        player.addWeapon(DullingWeapon(damage: 100, damageLostPerUse: 5, basePurchasePrice: 20))
        let enhancer = Enhancer(options: [.weaponDamage])
        enhancer.upgradeWeaponDamage(weapon: player.weapons.first!, by: 50, purchaser: player, price: 200)
        XCTAssertEqual(player.gold, 1)
        XCTAssertEqual(player.weapons.first!.damage, 150)
    }
    
    func testRestorer() throws {
        let player = Player(maxHealth: 200, location: NoLocation())
        player.modifyGold(by: 200)
        player.damage(for: 150)
        let restorer = Restorer(options: [.health], pricePerHealth: 5)
        restorer.restoreHealth(to: player, amount: 20)
        XCTAssertEqual(player.health, 70)
        XCTAssertEqual(player.gold, 200 - 5*20)
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
