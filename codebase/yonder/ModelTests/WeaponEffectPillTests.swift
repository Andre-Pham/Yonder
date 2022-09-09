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
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: LootOptions(LootBag(), LootBag(), LootBag()))
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

}
