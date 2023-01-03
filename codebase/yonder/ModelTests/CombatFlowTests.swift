//
//  CombatFlowTests.swift
//  ModelTests
//
//  Created by Andre Pham on 6/9/2022.
//

import XCTest
@testable import yonder

class CombatFlowTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
    
    func testDamageWeaponAndBuff() throws {
        self.player.addBuff(DamagePercentBuff(sourceName: "", direction: .outgoing, duration: 1, damageFraction: 2.0))
        self.player.addBuff(DamagePercentBuff(sourceName: "", direction: .incoming, duration: 1, damageFraction: 0.5))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 100/2)
        XCTAssertEqual(self.foe.health, 500 - 100*2)
    }
    
    func testHealthRestorationAndBuff() throws {
        self.player.addBuff(HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: 1, healthFraction: 2.0))
        self.foe.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 100))
        self.player.useWeaponWhere(opposition: self.foe, weapon: Weapon(basePill: HealthRestorationBasePill(healthRestoration: 50), durabilityPill: InfiniteDurabilityPill()))
        XCTAssertEqual(self.player.health, 500 - (100 + 100) + 50*2)
        XCTAssertEqual(self.foe.health, 500)
    }
    
    func testArmorPointsRestoration() throws {
        self.player.equipArmor(Armor(name: "", description: "", type: .body, armorPoints: 50, armorBuffs: [], equipmentPills: []))
        self.player.useWeaponWhere(opposition: self.foe, weapon: Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 25), durabilityPill: InfiniteDurabilityPill()))
        XCTAssertEqual(self.player.health, 450)
        XCTAssertEqual(self.player.armorPoints, 25)
    }

}
