//
//  WeaponEffectPillTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class WeaponEffectPillTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
    let turnManager = TestsTurnManager.turnManager
    
    // MARK: - Basic

    func testBurnStatusEffectEffectPill() throws {
        self.weapon.addEffect(BurnStatusEffectEffectPill(tickDamage: 5, duration: 2))
        // Test setup
        XCTAssertEqual(weapon.effectPills.count, 1)
        // Test logic
        self.player.addWeapon(self.weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.weapon)
        XCTAssertEqual(self.foe.statusEffects.count, 1)
        XCTAssertEqual(self.foe.health, 445)
    }
    
    func testGoblinEffectPill() throws {
        self.weapon.setDamage(to: 0)
        self.weapon.addEffect(GoblinEffectPill(goldPerSteal: 100, damage: 200))
        let foe = Foe(maxHealth: 200, weapon: self.weapon, loot: NoLootOptions())
        self.player.setGold(to: 150)
        foe.attack(self.player)
        self.turnManager.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 500)
        XCTAssertEqual(self.player.gold, 50)
        foe.attack(self.player)
        self.turnManager.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 500)
        XCTAssertEqual(self.player.gold, 0)
        foe.attack(self.player)
        self.turnManager.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 300)
        XCTAssertEqual(self.player.gold, 0)
    }

}
