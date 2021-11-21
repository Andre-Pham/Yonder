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
        let player = Player(maxHealth: 200)
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 195)
    }
    
    func testDeath() throws {
        let player = Player(maxHealth: 200)
        player.damage(for: 150)
        XCTAssertTrue(!player.isDead)
        player.damage(for: 150)
        XCTAssertTrue(player.isDead)
    }
    
    func testStatusEffects() throws {
        let player = Player(maxHealth: 200)
        player.addStatusEffect(BurnStatusEffect(damage: 5))
        player.triggerStatusEffects()
        XCTAssertTrue(player.health == 195)
    }
    
    func testTimedEvents() throws {
        let player = Player(maxHealth: 200)
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
        let player = Player(maxHealth: 200)
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 5))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 180)
    }
    
    func testBuffPriority() throws {
        let player = Player(maxHealth: 200)
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 25))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.addBuff(DamageBuff(duration: 5, damageDifference: 5))
        foe.addBuff(DamagePercentBuff(duration: 5, damageFraction: 2.0))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        XCTAssertTrue(player.health == 80)
    }
    
    func testArmor() throws {
        let player = Player(maxHealth: 200)
        player.equipArmor(TEST_HEAD_ARMOR)
        player.equipArmor(TEST_BODY_ARMOR)
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 100))
        foe.useWeaponOn(target: player, weapon: foe.getWeapon())
        print(player.health)
        XCTAssertTrue(player.armorPoints == player.headArmor.armorPoints + player.bodyArmor.armorPoints - 64)
    }
    
    func testHealingWeapon() throws {
        let player = Player(maxHealth: 200)
        player.addWeapon(HealthRestorationWeapon(healthRestoration: 50, durability: 2))
        player.damage(for: 100)
        player.useWeaponOn(target: player, weapon: player.weapons.first!)
        XCTAssertTrue(player.health == 150)
    }
    
    func testDullingWeapon() throws {
        let player = Player(maxHealth: 200)
        player.addWeapon(DullingWeapon(damage: 7, damageLostPerUse: 2))
        let foe = FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 100))
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        XCTAssertTrue(player.weapons.first!.damage == 1)
        XCTAssertTrue(player.weapons.first!.remainingUses == 1)
        player.useWeaponOn(target: foe, weapon: player.weapons.first!)
        XCTAssertTrue(player.weapons.first!.remainingUses == 0)
        XCTAssertTrue(foe.health == 200 - 7 - 5 - 3 - 1)
    }
    
    func testRestore() throws {
        var player = Player(maxHealth: 200)
        player.equipArmor(TEST_HEAD_ARMOR)
        player.damage(for: 250)
        XCTAssertEqual(player.health, 150)
        XCTAssertEqual(player.armorPoints, 0)
        player.restore(for: 100)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 50)
        player = Player(maxHealth: 200)
        player.equipArmor(TEST_HEAD_ARMOR)
        player.damage(for: 300)
        player.restore(for: 50)
        XCTAssertEqual(player.health, 150)
        XCTAssertEqual(player.armorPoints, 0)
    }
    
    func testPotion() throws {
        var player = Player(maxHealth: 200)
        player.damage(for: 100)
        player.addPotion(HealthRestorationPotion(healthRestoration: 50, potionCount: 1))
        player.potions.first!.use(owner: player, target: player)
        XCTAssertEqual(player.health, 150)
        player = Player(maxHealth: 200)
        player.equipArmor(TEST_HEAD_ARMOR)
        player.damage(for: 350)
        player.addPotion(FullRestorationPotion(potionCount: 1))
        player.potions.first!.use(owner: player, target: player)
        XCTAssertEqual(player.health, 200)
        XCTAssertEqual(player.armorPoints, 200)
    }
    
    func testRemoveWeapon() throws {
        let player = Player(maxHealth: 200)
        let weapon = BasicWeapon(damage: 5, durability: 2)
        player.addWeapon(weapon)
        player.useWeaponOn(target: player, weapon: weapon)
        XCTAssertEqual(player.weapons.count, 1)
        player.useWeaponOn(target: player, weapon: weapon)
        XCTAssertEqual(player.weapons.count, 0)
    }

}
