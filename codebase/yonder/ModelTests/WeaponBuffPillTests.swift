//
//  WeaponBuffPillTests.swift
//  ModelTests
//
//  Created by Andre Pham on 19/9/2022.
//

import XCTest
@testable import yonder

class WeaponBuffPillTests: XCTestCase {

    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: LootOptions(LootBag(), LootBag(), LootBag()))
    let turnManager = TestsTurnManager.turnManager
    
    // MARK: - Basic

    func testArmorDamagePercentBuffPill() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 5), durabilityPill: InfiniteDurabilityPill(), buffPills: [ArmorDamagePercentBuffPill(damageFraction: 2.0)])
        self.foe.equipAccessory(Accessory(name: "", description: "", type: .regular, healthBonus: 0, armorPointsBonus: 3, buffs: [], equipmentPills: []), replacing: nil)
        self.player.addWeapon(weapon)
        self.player.useWeaponWhere(opposition: self.foe, weapon: self.player.weapons.first!)
        // Foe has 500 health, 3 armor
        // Weapon deals 5 base damage, and deals double to armor
        // Weapon only requires 2 damage to get through armor, leaving 3 damage for health damage
        XCTAssertEqual(self.foe.armorPoints, 0)
        XCTAssertEqual(self.foe.health, 500 - 3)
    }

}
