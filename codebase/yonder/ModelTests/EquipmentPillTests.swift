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
    let foe = Foe(maxHealth: 500, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
    let foeZeroAttack = Foe(maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    let accessory = Accessory(name: "Test Accessory", description: "For testing.", type: .regular, healthBonus: 0, armorPointsBonus: 0, basePurchasePrice: 0, buffs: [], equipmentPills: [])
    let turnManager = TestsTurnManager.turnManager
    
    // MARK: - Basic
    
    func testThornsEquipmentPill() throws {
        self.accessory.addEquipmentPill(ThornsEquipmentPill(thornsFraction: 0.5, sourceName: "Test Accessory"))
        self.player.equipAccessory(self.accessory, replacing: nil)
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 0))
        XCTAssertEqual(self.foe.health, 450)
    }
    
    func testWeaponLifestealEquipmentPill() throws {
        self.accessory.addEquipmentPill(WeaponLifestealEquipmentPill(lifestealFraction: 0.5, sourceName: "Test Accessory"))
        self.player.equipAccessory(self.accessory, replacing: nil)
        self.player.damage(for: 200)
        self.player.useWeaponWhere(opposition: self.foeZeroAttack, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.foeZeroAttack.health, 400)
        XCTAssertEqual(self.player.health, 350)
    }
    
    func testPhoenixEquipmentPill() throws {
        self.accessory.addEquipmentPill(PhoenixEquipmentPill(sourceName: "Test Accessory"))
        self.player.equipAccessory(self.accessory, replacing: nil)
        self.player.damage(for: 500)
        self.turnManager.completeTurn(player: self.player)
        XCTAssertTrue(!self.player.isDead)
        XCTAssertTrue(self.player.accessorySlots.accessories.isEmpty)
        
        let armor = Armor(name: "", description: "", type: .body, armorPoints: 0, basePurchasePrice: 10, armorBuffs: [], equipmentPills: [PhoenixEquipmentPill(sourceName: "")])
        self.player.equipArmor(armor)
        self.player.damage(for: 1000)
        self.turnManager.completeTurn(player: self.player)
        XCTAssertTrue(!self.player.isDead)
        XCTAssertTrue(self.player.bodyArmor is NoArmor)
    }
    
    // MARK: - Interactions

    func testWeaponLifestealWithDulling() throws {
        let weapon = Weapon(basePill: DamageBasePill(damage: 100), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50))
        self.player.addWeapon(weapon)
        self.accessory.addEquipmentPill(WeaponLifestealEquipmentPill(lifestealFraction: 1.0, sourceName: "Test Accessory"))
        self.player.equipAccessory(self.accessory, replacing: nil)
        self.player.damage(for: 200)
        self.player.useWeaponWhere(opposition: self.foeZeroAttack, weapon: weapon)
        XCTAssertEqual(self.foeZeroAttack.health, 400)
        XCTAssertEqual(self.player.health, 400)
    }
    
    func testWeaponLifestealWithBuffs() throws {
        self.accessory.addEquipmentPill(WeaponLifestealEquipmentPill(lifestealFraction: 1.0, sourceName: "Test Accessory"))
        self.player.equipAccessory(self.accessory, replacing: nil)
        self.player.damage(for: 400)
        self.player.addBuff(HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        self.player.addBuff(DamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0))
        self.player.useWeaponWhere(opposition: self.foeZeroAttack, weapon: BaseAttack(damage: 50))
        // 50 damage. x2 from damage buff = 100 damage. -> 100 healing. x2 from health buff = 200 healing.
        XCTAssertEqual(self.player.health, 300)
    }

}
