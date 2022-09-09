//
//  BuffTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class BuffTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
    let foeZeroAttack = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    let baseHealthRestorationWeapon = Weapon(basePill: HealthRestorationBasePill(healthRestoration: 100), durabilityPill: InfiniteDurabilityPill())
    let baseArmorPointsRestorationWeapon = Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 100), durabilityPill: InfiniteDurabilityPill())
    let turnManager = TestsTurnManager.turnManager
    
    // MARK: - Basic
    
    func testBuffTimeRemaining() throws {
        let buff = DamageBuff(sourceName: "", direction: .incoming, duration: 2, damageDifference: 5)
        XCTAssertFalse(buff.isInfinite)
        self.player.addBuff(buff)
        self.turnManager.completeTurn(player: self.player)
        XCTAssertEqual(self.player.buffs.first!.timeRemaining, 1)
        self.turnManager.completeTurn(player: self.player)
        XCTAssertTrue(self.player.buffs.isEmpty)
    }
    
    func testInfiniteBuff() throws {
        let buff = DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: 5)
        XCTAssertTrue(buff.isInfinite)
        self.player.addBuff(buff)
        let timeRemaining = buff.timeRemaining
        XCTAssertTrue(timeRemaining == nil)
        self.turnManager.completeTurn(player: self.player)
        XCTAssertEqual(timeRemaining, buff.timeRemaining)
    }
    
    func testWeaponDamageBuffTargetsCorrectly() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .bidirectional, duration: nil, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foeZeroAttack, weapon: BaseAttack(damage: 0))
        XCTAssertEqual(self.player.health, self.player.maxHealth)
        XCTAssertEqual(self.foeZeroAttack.health, self.foeZeroAttack.maxHealth)
        // - TODO: health, armorPoints, price, goldBonus
    }
    
    func testPotionBuffsTargetCorrectly() throws {
        // We don't want a damage buff causing a health potion to deal damage
        let potion = HealthRestorationPotion(tier: .I, potionCount: 1, basePurchasePrice: 10)
        self.player.damage(for: 100)
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 100))
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.foeZeroAttack.health, 500)
    }
    
    func testBuffOrdering() throws {
        let damageBuff = DamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 50)
        let damagePercentageBuff = DamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0)
        self.player.addBuff(damageBuff)
        self.player.addBuff(damagePercentageBuff)
        if damageBuff.priority == .first && damagePercentageBuff.priority == .second {
            XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 300)
        } else if damageBuff.priority == .second && damagePercentageBuff.priority == .first {
            XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 250)
        } else {
            assertionFailure("testBuffOrdering needs to be updated")
        }
    }
    
    func testOutgoingDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 100)
        XCTAssertEqual(self.foe.health, 500 - 110)
    }
    
    func testIncomingDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .incoming, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 110)
        XCTAssertEqual(self.foe.health, 500 - 100)
    }
    
    func testBidirectionalDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .bidirectional, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 110)
        XCTAssertEqual(self.foe.health, 500 - 110)
    }
    
    func testDamagePercentBuff() throws {
        self.player.addBuff(DamagePercentBuff(sourceName: "", direction: .outgoing, duration: 1, damageFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: self.foeZeroAttack), 200)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1, basePurchasePrice: 10), opposition: self.foeZeroAttack), DamagePotion.Tier.I.damage*2)
    }
    
    func testDamageBuff() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 10))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: self.foeZeroAttack), 110)
    }
    
    func testHealthRestorationPercentBuff() throws {
        self.player.addBuff(HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 200)
    }
    
    func testArmorPointsRestorationPercentBuff() throws {
        self.player.addBuff(ArmorPointsRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 200)
    }
    
    func testPricePercentBuff() throws {
        self.player.addBuff(PricePercentBuff(sourceName: "", duration: nil, priceFraction: 2.0))
        self.player.modifyGold(by: 500)
        self.player.modifyGoldAdjusted(by: -100)
        XCTAssertEqual(self.player.gold, 500 - 100*2)
    }
    
    func testPotionDamagePercentBuff() throws {
        self.player.addBuff(PotionDamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 100)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1, basePurchasePrice: 10), opposition: NoActor()), DamagePotion.Tier.I.damage*2)
    }

}
