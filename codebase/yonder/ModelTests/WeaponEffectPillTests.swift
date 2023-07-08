//
//  WeaponEffectPillTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class WeaponEffectPillTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(contentID: nil, maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill())
    
    // MARK: - Basic

    func testBurnStatusEffectEffectPill() throws {
        self.weapon.addEffect(BurnStatusEffectEffectPill(tickDamage: 5, duration: 2))
        // Test setup
        XCTAssertEqual(weapon.effectPills.count, 1)
        // Test logic
        self.player.addWeapon(self.weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.player.weapons.first!)
        XCTAssertEqual(self.foe.statusEffects.count, 1)
        XCTAssertEqual(self.foe.health, 445)
    }
    
    func testGoblinEffectPill() throws {
        self.weapon.setDamage(to: 0)
        self.weapon.addEffect(GoblinEffectPill(goldPerSteal: 100, damage: 200))
        let foe = Foe(contentID: nil, maxHealth: 200, weapon: self.weapon, loot: NoLootOptions())
        self.player.setGold(to: 150)
        foe.attack(self.player)
        self.testSession.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 500)
        XCTAssertEqual(self.player.gold, 50)
        XCTAssertEqual(foe.getWeapon().damage, 0)
        foe.attack(self.player)
        self.testSession.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 500)
        XCTAssertEqual(self.player.gold, 0)
        XCTAssertEqual(foe.getWeapon().damage, 200)
        foe.attack(self.player)
        self.testSession.completeTurn(player: self.player, playerUsed: NoItem(), foe: foe)
        XCTAssertEqual(self.player.health, 300)
        XCTAssertEqual(self.player.gold, 0)
        self.player.modifyGold(by: 1)
        XCTAssertEqual(foe.getWeapon().damage, 0)
    }
    
    func testCopyAttackEffectPill() throws {
        self.weapon.addEffect(CopyAttackEffectPill())
        self.foe.getWeapon().setDamage(to: 20)
        self.player.addWeapon(self.weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.player.weapons.first!)
        XCTAssertEqual(self.player.weapons.first!.damage, 50)
        self.foe.setHealth(to: 1)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.player.weapons.first!)
        XCTAssertEqual(self.player.weapons.first!.damage, 20)
    }
    
    func testLifestealEffectPill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: InfiniteDurabilityPill(), effectPills: [LifestealEffectPill(lifestealFraction: 1.0)])
        self.player.damage(for: 150)
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 450)
        XCTAssertEqual(self.player.health, 400)
        weapon.setDamage(to: 100)
        self.foe.addBuff(DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: -10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 360)
        XCTAssertEqual(self.player.health, 490)
    }

}
