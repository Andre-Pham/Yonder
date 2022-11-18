//
//  ConsumableTests.swift
//  ModelTests
//
//  Created by Andre Pham on 9/9/2022.
//

import XCTest
@testable import yonder

class ConsumableTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
    
    func testConsumableRemoval() throws {
        self.player.addConsumable(MultiplyGoldConsumable(goldFraction: 2.0, amount: 1))
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.consumables.count, 0)
    }
    
    func testStackable() throws {
        self.player.addConsumable(MultiplyGoldConsumable(goldFraction: 2.0, amount: 1))
        self.player.addConsumable(MultiplyGoldConsumable(goldFraction: 2.0, amount: 1))
        XCTAssertEqual(self.player.consumables.count, 1)
        XCTAssertEqual(self.player.consumables.first!.remainingUses, 2)
    }
    
    func testRandomHealthConsumable() throws {
        var health = self.player.health
        self.player.useConsumableWhere(opposition: nil, consumable: RandomHealthConsumable(amount: 1))
        XCTAssertNotEqual(health, self.player.health)
        health = self.player.health
        self.player.useConsumableWhere(opposition: nil, consumable: RandomHealthConsumable(amount: 1))
        XCTAssertNotEqual(health, self.player.health)
    }
    
    func testMultiplyGoldConsumable() throws {
        self.player.modifyGold(by: 500)
        self.player.useConsumableWhere(opposition: nil, consumable: MultiplyGoldConsumable(goldFraction: 2.0, amount: 1))
        XCTAssertEqual(self.player.gold, 1000)
    }
    
    func testAdjustMaxHealthConsumable() throws {
        self.player.useConsumableWhere(opposition: nil, consumable: BonusHealthConsumable(tier: .I, amount: 1))
        XCTAssertEqual(self.player.maxHealth, 500 + BonusHealthConsumable.Tier.I.amount)
        XCTAssertEqual(self.player.health, 500 + BonusHealthConsumable.Tier.I.amount)
    }
    
    func testRipeningSetHealthConsumable() throws {
        // Add 4 to the stack
        for _ in 0..<4 {
            self.player.addConsumable(RipeningSetHealthConsumable(amount: 1))
        }
        self.player.adjustBonusHealth(by: 999 - self.player.health)
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, 999/3)
        for _ in 0..<8 { self.player.travel(to: NoLocation()) }
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, 2*999/3)
        for _ in 0..<8 { self.player.travel(to: NoLocation()) }
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, self.player.maxHealth)
        for _ in 0..<8 { self.player.travel(to: NoLocation()) }
        self.player.setHealth(to: 1)
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, 1)
    }
    
    func testTurnImprovingRestorationConsumable() throws {
        let startingRestoration = 10
        let restorationIncrease = 8
        self.player.addConsumable(TravelImprovingRestorationConsumable(amount: 1))
        self.player.addConsumable(TravelImprovingRestorationConsumable(amount: 1))
        self.player.setHealth(to: 100)
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, 100 + startingRestoration)
        for _ in 0..<10 { self.player.travel(to: NoLocation()) }
        self.player.useConsumableWhere(opposition: nil, consumable: self.player.consumables.first!)
        XCTAssertEqual(self.player.health, 110 + startingRestoration + restorationIncrease*10)
    }
    
    func testRestoreArmorPointsConsumable() throws {
        let consumable = RestoreArmorPointsConsumable(tier: .I, amount: 1)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: consumable), consumable.tier.armorPointsRestoration)
    }

}
