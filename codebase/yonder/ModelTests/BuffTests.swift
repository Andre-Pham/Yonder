//
//  BuffTests.swift
//  ModelTests
//
//  Created by Andre Pham on 31/8/2022.
//

import XCTest
@testable import yonder

class BuffTests: XCTestCase {

    let testSession = TestSession.instance // Begin test session
    let player = Player(maxHealth: 500, location: NoLocation())
    let foe = Foe(contentID: nil, maxHealth: 500, weapon: BaseAttack(damage: 100), loot: NoLootOptions())
    let foeZeroAttack = Foe(contentID: nil, maxHealth: 500, weapon: BaseAttack(damage: 0), loot: NoLootOptions())
    let baseHealthRestorationWeapon = Weapon(basePill: HealthRestorationBasePill(healthRestoration: 100), durabilityPill: InfiniteDurabilityPill())
    let baseArmorPointsRestorationWeapon = Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 100), durabilityPill: InfiniteDurabilityPill())
    
    // MARK: - Basic
    
    func testBuffTimeRemaining() throws {
        let buff = DamageBuff(sourceName: "", direction: .incoming, duration: 2, damageDifference: 5)
        XCTAssertFalse(buff.isInfinite)
        self.player.addBuff(buff)
        self.testSession.completeTurn(player: self.player)
        XCTAssertEqual(self.player.buffs.first!.timeRemaining, 1)
        self.testSession.completeTurn(player: self.player)
        XCTAssertTrue(self.player.buffs.isEmpty)
    }
    
    func testInfiniteBuff() throws {
        let buff = DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: 5)
        XCTAssertTrue(buff.isInfinite)
        self.player.addBuff(buff)
        let timeRemaining = buff.timeRemaining
        XCTAssertTrue(timeRemaining == nil)
        self.testSession.completeTurn(player: self.player)
        XCTAssertEqual(timeRemaining, buff.timeRemaining)
    }
    
    func testWeaponDamageBuffTargetsCorrectly() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .bidirectional, duration: nil, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foeZeroAttack, weapon: BaseAttack(damage: 0))
        XCTAssertEqual(self.player.health, self.player.maxHealth)
        XCTAssertEqual(self.foeZeroAttack.health, self.foeZeroAttack.maxHealth)
        // - TODO: health, armorPoints, price, goldBonus
    }
    
    func testPotionBuffsTargetCorrectly() throws {
        // We don't want a damage buff causing a health potion to deal damage
        let potion = HealthRestorationPotion(tier: .I, potionCount: 1)
        self.player.damage(for: 100)
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 100))
        self.player.usePotionWhere(opposition: self.foeZeroAttack, potion: potion)
        XCTAssertEqual(self.foeZeroAttack.health, 500)
    }
    
    func testBuffOrdering() throws {
        let damageBuff = DamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 50)
        let damagePercentageBuff = DamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0)
        self.player.addBuff(damageBuff)
        self.player.addBuff(damagePercentageBuff)
        if damageBuff.priority == .first && damagePercentageBuff.priority == .second {
            XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 300)
        } else if damageBuff.priority == .second && damagePercentageBuff.priority == .first {
            XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 250)
        } else {
            assertionFailure("testBuffOrdering needs to be updated")
        }
    }
    
    func testOutgoingDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 100)
        XCTAssertEqual(self.foe.health, 500 - 110)
    }
    
    func testIncomingDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .incoming, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 110)
        XCTAssertEqual(self.foe.health, 500 - 100)
    }
    
    func testBidirectionalDirection() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .bidirectional, duration: 1, damageDifference: 10))
        self.player.useWeaponWhere(opposition: self.foe, weapon: BaseAttack(damage: 100))
        XCTAssertEqual(self.player.health, 500 - 110)
        XCTAssertEqual(self.foe.health, 500 - 110)
    }
    
    func testDamagePercentBuff() throws {
        self.player.addBuff(DamagePercentBuff(sourceName: "", direction: .outgoing, duration: 1, damageFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: self.foeZeroAttack), 200)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1), opposition: self.foeZeroAttack), DamagePotion.Tier.I.damage*2)
    }
    
    func testDamageBuff() throws {
        self.player.addBuff(DamageBuff(sourceName: "", direction: .outgoing, duration: 1, damageDifference: 10))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: self.foeZeroAttack), 110)
    }
    
    func testHealthRestorationPercentBuff() throws {
        self.player.addBuff(HealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 200)
    }
    
    func testArmorPointsRestorationPercentBuff() throws {
        self.player.addBuff(ArmorPointsRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 200)
    }
    
    func testPricePercentBuff() throws {
        self.player.addBuff(PricePercentBuff(sourceName: "", duration: nil, priceFraction: 2.0))
        self.player.modifyGold(by: 500)
        self.player.modifyGoldAdjusted(by: -100)
        XCTAssertEqual(self.player.gold, 500 - 100*2)
    }
    
    func testPotionDamagePercentBuff() throws {
        self.player.addBuff(PotionDamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 100)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1), opposition: NoActor()), DamagePotion.Tier.I.damage*2)
    }
    
    func testArmorPointsRestorationBuff() throws {
        self.player.addBuff(ArmorPointsRestorationBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsDifference: 5))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 105)
    }
    
    func testHealthRestorationBuff() throws {
        self.player.addBuff(HealthRestorationBuff(sourceName: "", direction: .incoming, duration: nil, healthDifference: 5))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 105)
    }
    
    func testWeaponDamagePercentBuff() throws {
        self.player.addBuff(WeaponDamagePercentBuff(sourceName: "", direction: .outgoing, duration: nil, damageFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 200)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1), opposition: NoActor()), DamagePotion.Tier.I.damage)
    }
    
    func testPotionDamageBuff() throws {
        self.player.addBuff(PotionDamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 10))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 100)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1), opposition: NoActor()), DamagePotion.Tier.I.damage + 10)
    }
    
    func testWeaponDamageBuff() throws {
        self.player.addBuff(WeaponDamageBuff(sourceName: "", direction: .outgoing, duration: nil, damageDifference: 10))
        XCTAssertEqual(self.player.getIndicativeDamage(of: BaseAttack(damage: 100), opposition: NoActor()), 110)
        XCTAssertEqual(self.player.getIndicativeDamage(of: DamagePotion(tier: .I, potionCount: 1), opposition: NoActor()), DamagePotion.Tier.I.damage)
    }
    
    func testPotionHealthRestorationPercentBuff() throws {
        self.player.addBuff(PotionHealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 100)
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: HealthRestorationPotion(tier: .I, potionCount: 1)), HealthRestorationPotion.Tier.I.healthRestoration*2)
    }
    
    func testWeaponHealthRestorationPercentBuff() throws {
        self.player.addBuff(WeaponHealthRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, healthFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 200)
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: HealthRestorationPotion(tier: .I, potionCount: 1)), HealthRestorationPotion.Tier.I.healthRestoration)
    }
    
    func testPotionHealthRestorationBuff() throws {
        self.player.addBuff(PotionHealthRestorationBuff(sourceName: "", direction: .incoming, duration: nil, healthDifference: 10))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 100)
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: HealthRestorationPotion(tier: .I, potionCount: 1)), HealthRestorationPotion.Tier.I.healthRestoration + 10)
    }
    
    func testWeaponHealthRestorationBuff() throws {
        self.player.addBuff(WeaponHealthRestorationBuff(sourceName: "", direction: .incoming, duration: nil, healthDifference: 10))
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: self.baseHealthRestorationWeapon), 110)
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: HealthRestorationPotion(tier: .I, potionCount: 1)), HealthRestorationPotion.Tier.I.healthRestoration)
    }
    
    func testWeaponArmorPointsRestorationPercentBuff() throws {
        self.player.addBuff(WeaponArmorPointsRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 200)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: RestoreArmorPointsConsumable(tier: .I, amount: 1)), RestoreArmorPointsConsumable.Tier.I.armorPointsRestoration)
    }
    
    func testConsumableArmorPointsRestorationPercentBuff() throws {
        self.player.addBuff(ConsumableArmorPointsRestorationPercentBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsFraction: 2.0))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 100)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: RestoreArmorPointsConsumable(tier: .I, amount: 1)), RestoreArmorPointsConsumable.Tier.I.armorPointsRestoration*2)
    }
    
    func testWeaponArmorPointsRestorationBuff() throws {
        self.player.addBuff(WeaponArmorPointsRestorationBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsDifference: 10))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 110)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: RestoreArmorPointsConsumable(tier: .I, amount: 1)), RestoreArmorPointsConsumable.Tier.I.armorPointsRestoration)
    }
    
    func testConsumableArmorPointsRestorationBuff() throws {
        self.player.addBuff(ConsumableArmorPointsRestorationBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsDifference: 10))
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: self.baseArmorPointsRestorationWeapon), 100)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: RestoreArmorPointsConsumable(tier: .I, amount: 1)), RestoreArmorPointsConsumable.Tier.I.armorPointsRestoration + 10)
    }
    
    func testPriceBuff() throws {
        self.player.addBuff(PriceBuff(sourceName: "", duration: nil, priceDifference: 50))
        self.player.setGold(to: 500)
        self.player.modifyGoldAdjusted(by: -100)
        // Price difference is $50, so you're paying an extra $50
        XCTAssertEqual(self.player.gold, 500 - 100 - 50)
        self.player.clearBuffs()
        self.player.addBuff(PriceBuff(sourceName: "", duration: nil, priceDifference: -50))
        self.player.setGold(to: 500)
        self.player.modifyGoldAdjusted(by: -100)
        // Price difference is -$50, so you're paying $50 less
        XCTAssertEqual(self.player.gold, 500 - 100 + 50)
        self.player.setGold(to: 500)
        self.player.modifyGoldAdjusted(by: -5)
        // Make sure that if you have to pay less than the deduction, that:
        // 1. You still pay something (test there is a minimum payment amount)
        // 2. You pay less than the original amount (you still get a discount even if you reach the minimum payment amount)
        XCTAssert(self.player.gold > 495 && self.player.gold < 500)
    }
    
    func testGoldPercentBuff() throws {
        self.player.addBuff(GoldPercentBuff(sourceName: "", duration: nil, goldFraction: 2.0))
        self.player.modifyGoldAdjusted(by: 500)
        XCTAssertEqual(self.player.gold, 500*2)
    }
    
    func testGoldBuff() throws {
        self.player.addBuff(GoldBuff(sourceName: "", duration: nil, goldDifference: 100))
        self.player.modifyGoldAdjusted(by: 50)
        XCTAssertEqual(self.player.gold, 150)
        self.player.addBuff(GoldBuff(sourceName: "", duration: nil, goldDifference: -1000))
        self.player.modifyGoldAdjusted(by: 50)
        // If we pay the player $50, and they have a debuff that reduces all paid out gold by -$1000, we give them $0, we don't take away their already-earned gold
        XCTAssertEqual(self.player.gold, 150)
    }
    
    func testZeroBuffs() throws {
        self.player.addBuff(GoldBuff(sourceName: "", duration: nil, goldDifference: 100))
        self.player.addBuff(DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: 100))
        self.player.setHealth(to: 100)
        self.player.addBuff(HealthRestorationBuff(sourceName: "", direction: .incoming, duration: nil, healthDifference: 100))
        self.player.equipAccessory(Accessory(name: "", description: "", type: .regular, healthBonus: 0, armorPointsBonus: 100, buffs: [], equipmentPills: []), replacing: nil)
        self.player.setArmorPoints(to: 0)
        self.player.addBuff(ArmorPointsRestorationBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsDifference: 100))
        // Adjust values by 0 and make sure a 0 buff isn't adjusted
        self.player.modifyGoldAdjusted(by: 0)
        XCTAssertEqual(player.gold, 0)
        self.player.damageAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 0)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 0)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreHealthAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 0)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreArmorPointsAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 0)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
    }
    
    func testNegativeBuffs() throws {
        self.player.setGold(to: 1000)
        self.player.addBuff(GoldBuff(sourceName: "", duration: nil, goldDifference: -100))
        self.player.addBuff(DamageBuff(sourceName: "", direction: .incoming, duration: nil, damageDifference: -100))
        self.player.setHealth(to: 100)
        self.player.addBuff(HealthRestorationBuff(sourceName: "", direction: .incoming, duration: nil, healthDifference: -100))
        self.player.equipAccessory(Accessory(name: "", description: "", type: .regular, healthBonus: 0, armorPointsBonus: 100, buffs: [], equipmentPills: []), replacing: nil)
        self.player.setArmorPoints(to: 0)
        self.player.addBuff(ArmorPointsRestorationBuff(sourceName: "", direction: .incoming, duration: nil, armorPointsDifference: -100))
        // Adjust values by <100 and make sure the player doesn't lose stats - it's just cancelled out
        self.player.modifyGoldAdjusted(by: 5)
        XCTAssertEqual(self.player.gold, 1000)
        self.player.damageAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 5)
        XCTAssertEqual(self.player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 5)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreHealthAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 5)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        self.player.restoreArmorPointsAdjusted(sourceOwner: NoActor(), using: NoItem(), for: 5)
        XCTAssertEqual(player.health, 100)
        XCTAssertEqual(player.armorPoints, 0)
        // Make sure this is consistent through indicative values
        XCTAssertEqual(self.player.getIndicativePayout(from: 5), 0)
        XCTAssertEqual(self.foe.getIndicativeDamage(of: BaseAttack(damage: 5), opposition: self.player), 0)
        XCTAssertEqual(self.player.getIndicativeHealthRestoration(of: HealthRestorationPotion(tier: .I, potionCount: 1)), 0)
        XCTAssertEqual(self.player.getIndicativeArmorPointsRestoration(of: RestoreArmorPointsConsumable(tier: .I, amount: 1)), 0)
        XCTAssertEqual(self.player.getIndicativeRestoration(of: TravelImprovingRestorationConsumable(amount: 1)).0, 0)
        XCTAssertEqual(self.player.getIndicativeRestoration(of: TravelImprovingRestorationConsumable(amount: 1)).1, 0)
    }

}
