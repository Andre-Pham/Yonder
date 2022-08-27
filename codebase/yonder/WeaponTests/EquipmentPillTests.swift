//
//  EquipmentPillTests.swift
//  ModelTests
//
//  Created by Andre Pham on 27/8/2022.
//

import XCTest
@testable import yonder

class EquipmentPillTests: XCTestCase {
    
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: LootOptions(LootBag(), LootBag(), LootBag()))
    
    // MARK: - Basic
    
    // MARK: - Interactions

    func testWeaponLifestealWithDulling() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50))
        self.player.addWeapon(weapon)
        self.player.equipAccessory(Accessory(name: "Lifesteal Accessory", description: "Very cool.", type: .regular, healthBonus: 0, armorPointsBonus: 0, basePurchasePrice: 0, buffs: [], equipmentPills: [WeaponLifestealEquipmentPill(lifestealFraction: 1.0, sourceName: "")]), replacing: nil)
        self.player.damage(for: 200)
        self.player.useWeaponWhere(opposition: self.foe, weapon: weapon)
        XCTAssertEqual(self.foe.health, 400)
        XCTAssertEqual(self.player.health, 400)
    }

}
