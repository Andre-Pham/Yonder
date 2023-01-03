//
//  ItemTests.swift
//  ModelTests
//
//  Created by Andre Pham on 11/12/2022.
//

import XCTest
@testable import yonder

final class ItemTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: LootOptions(LootBag(), LootBag(), LootBag()))
    
    func testIndicativeDamage() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 70), durabilityPill: InfiniteDurabilityPill(), buffPills: [ArmorDamagePercentBuffPill(damageFraction: 2.0)])
        self.player.addWeapon(weapon)
        self.foe.equipArmor(Armor(name: "", description: "", type: .body, armorPoints: 50, armorBuffs: [], equipmentPills: []))
        let indicativeDamage = self.player.getIndicativeDamage(of: self.player.weapons.first!, opposition: self.foe)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.player.weapons.first!)
        let realDamage = self.foe.maxHealth + self.foe.maxArmorPoints - self.foe.health - self.foe.armorPoints
        XCTAssertEqual(indicativeDamage, realDamage)
    }

}
