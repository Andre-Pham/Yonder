//
//  PotionTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class PotionTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    let foeZeroAttack = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    
    // MARK: - Basic
    
    func testStackable() throws {
        let potion1 = DamagePotion(tier: .I, potionCount: 5, basePurchasePrice: 5)
        let potion2 = DamagePotion(tier: .I, potionCount: 1, basePurchasePrice: 1)
        let potion3 = HealthRestorationPotion(tier: .I, potionCount: 5, basePurchasePrice: 5)
        let potion4 = DamagePotion(tier: .II, potionCount: 1, basePurchasePrice: 1)
        XCTAssertTrue(potion1.isStackable(with: potion2))
        XCTAssertTrue(potion2.isStackable(with: potion1))
        XCTAssertFalse(potion1.isStackable(with: potion3))
        XCTAssertFalse(potion1.isStackable(with: potion4))
        for potion in [potion1, potion2, potion3, potion4] {
            self.player.addPotion(potion as! Potion)
        }
        XCTAssertEqual(self.player.potions.count, 3)
    }
    
    func testPotionRemoval() throws {
        let potion = HealthRestorationPotion(tier: .I, potionCount: 1, basePurchasePrice: 10)
        self.player.addPotion(potion)
        XCTAssertEqual(self.player.potions.count, 1)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: self.player.potions.first!)
        XCTAssertTrue(self.player.potions.isEmpty)
    }
    
    func testHealthRestorationPotion() throws {
        self.player.damage(for: 300)
        let potion = HealthRestorationPotion(tier: .I, potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.player.health, 200 + HealthRestorationPotion.Tier.I.healthRestoration)
    }
    
    func testMaxRestorationPotion() throws {
        self.player.equipArmor(Armor(name: "", description: "", type: .body, armorPoints: 200, basePurchasePrice: 10, armorBuffs: [], equipmentPills: []))
        self.player.damage(for: 699)
        let potion = MaxRestorationPotion(potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.player.health, self.player.maxHealth)
        XCTAssertEqual(self.player.armorPoints, self.player.maxArmorPoints)
    }
    
    func testDamagePotion() throws {
        let potion = DamagePotion(tier: .I, potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.foeZeroAttack.health, self.foeZeroAttack.maxHealth - DamagePotion.Tier.I.damage)
    }
    
    func testMaxHealthRestorationPotion() throws {
        self.player.damage(for: 499)
        let potion = MaxHealthRestorationPotion(potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.player.health, self.player.maxHealth)
    }
    
    func testDamagePercentBuffPotion() throws {
        let potion = DamagePercentBuffPotion(tier: .I, duration: 1, potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.player.buffs.count, 1)
        if let damagePercentBuff = self.player.buffs.first {
            XCTAssertTrue(damagePercentBuff is DamagePercentBuff)
            XCTAssertEqual(damagePercentBuff.timeRemaining, 1)
        }
    }
    
    func testHealthRestorationPercentBuffPotion() throws {
        let potion = HealthRestorationPercentBuffPotion(tier: .I, duration: 1, potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.player.buffs.count, 1)
        if let damagePercentBuff = self.player.buffs.first {
            XCTAssertTrue(damagePercentBuff is HealthRestorationPercentBuff)
            XCTAssertEqual(damagePercentBuff.timeRemaining, 1)
        }
    }
    
    func testWeaknessPotion() throws {
        let potion = WeaknessPotion(tier: .I, duration: 1, potionCount: 1, basePurchasePrice: 10)
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.foeZeroAttack.buffs.count, 1)
        if let damagePercentBuff = self.foeZeroAttack.buffs.first {
            XCTAssertTrue(damagePercentBuff is DamagePercentBuff)
            XCTAssertEqual(damagePercentBuff.timeRemaining, 1)
        }
    }

}
