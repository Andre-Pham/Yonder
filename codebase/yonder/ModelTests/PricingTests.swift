//
//  PricingTests.swift
//  ModelTests
//
//  Created by Andre Pham on 24/10/2022.
//

import XCTest
@testable import yonder

final class PricingTests: XCTestCase {
    
    let testSession = TestSession.instance // Begin test session

    func testBuffDuration() throws {
        let buff1 = DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 20)
        let buff2 = DamageBuff(sourceName: "", direction: .outgoing, duration: 2, damageDifference: 20)
        let buff3 = DamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 20)
        let value1 = buff1.getValue(whenTargeting: .player)
        let value2 = buff2.getValue(whenTargeting: .player)
        let value3 = buff3.getValue(whenTargeting: .player)
        XCTAssertTrue(value1 < value2)
        XCTAssertTrue(value2 < value3)
    }
    
    func testPercentBuffDuration() throws {
        let buff1 = DamagePercentBuff(sourceName: "", direction: .outgoing, duration: 1, damageFraction: 1.2)
        let buff2 = DamagePercentBuff(sourceName: "", direction: .outgoing, duration: 2, damageFraction: 1.2)
        let buff3 = DamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 1.2)
        let value1 = buff1.getValue(whenTargeting: .player)
        let value2 = buff2.getValue(whenTargeting: .player)
        let value3 = buff3.getValue(whenTargeting: .player)
        XCTAssertTrue(value1 < value2)
        XCTAssertTrue(value2 < value3)
    }
    
    func testNegativeValue() throws {
        let amountBuff = DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: 20)
        XCTAssertTrue(amountBuff.getValue(whenTargeting: .player) < 0)
        XCTAssertTrue(amountBuff.getValue(whenTargeting: .foe) > 0)
        let percentBuff = DamagePercentBuff(sourceName: "", direction: .incoming, duration: nil, damageFraction: 1.5)
        XCTAssertTrue(percentBuff.getValue(whenTargeting: .player) < 0)
        XCTAssertTrue(percentBuff.getValue(whenTargeting: .foe) > 0)
    }
    
    func testStages() throws {
        let buff = HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0)
        let price1 = Pricing.usingStage(stage: 1) { buff.getValue(whenTargeting: .player) }
        let price2 = Pricing.usingStage(stage: 5) { buff.getValue(whenTargeting: .player) }
        XCTAssertTrue(price1 < price2)
    }
    
    // MARK: - Gameplay tests
    // These are from gameplay testing where values are objectively wrong
    
    func testGameplayBuffValues() throws {
        var buff: Buff
        buff = DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: -7)
        XCTAssertTrue(buff.getValue(whenTargeting: .player) > 0)
        XCTAssertTrue(buff.getValue(whenTargeting: .foe) < 0)
    }
    
    func testGameplayConsumableValues() throws {
        var consumable: Consumable
        consumable = MaxRestoreAllConsumable(amount: 1)
        XCTAssertTrue(consumable.getBasePurchasePrice() > 0)
    }
    
    // MARK: - Report
    
    func testBalance() throws {
        var desc: String
        var price: String
        print("============================== PRICING BALANCE REPORT ==============================")
        
        let damagePotion = DamagePotion(tier: .II, potionCount: 3)
        desc = "\(damagePotion.remainingUses)x \(damagePotion.name). \(DamagePotion.Tier.II.damage) damage."
        price = "$\(damagePotion.getBasePurchasePrice())"
        print(self.insertSpaces(start: desc, end: price))
        
        let healthRestorationPotion = HealthRestorationPotion(tier: .II, potionCount: 1)
        desc = "\(healthRestorationPotion.remainingUses)x \(healthRestorationPotion.name). \(HealthRestorationPotion.Tier.II.healthRestoration) healing."
        price = "$\(healthRestorationPotion.getBasePurchasePrice())"
        print(self.insertSpaces(start: desc, end: price))
        
        let resistanceArmor = Armor(name: "Resistance Armor", description: "", type: .body, armorPoints: 200, armorBuffs: [DamagePercentBuff(sourceName: "Resistance Armor", direction: .incoming, duration: nil, damageFraction: 0.8)], equipmentPills: [], armorAttributes: [])
        desc = "\(resistanceArmor.name). \(resistanceArmor.armorPoints) shields. \(resistanceArmor.getEffectsDescription()!)"
        price = "$\(resistanceArmor.getBasePurchasePrice())"
        print(self.insertSpaces(start: desc, end: price))
        
        let basicWeapon = Weapon(name: "Weapon", description: "", basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5), effectPills: [], buffPills: [])
        desc = "\(basicWeapon.name). \(basicWeapon.remainingUses) durability. \(basicWeapon.damage) damage."
        price = "$\(basicWeapon.getBasePurchasePrice())"
        print(self.insertSpaces(start: desc, end: price))
        
        print("============================== END OF REPORT =======================================")
    }
    
    private func insertSpaces(start: String, end: String) -> String {
        let requiredLength = 84
        let requiredCount = requiredLength - start.count - end.count
        let spaces = String(repeating: " ", count: requiredCount)
        return start + spaces + end
    }

}
