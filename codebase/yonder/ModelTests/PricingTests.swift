//
//  PricingTests.swift
//  ModelTests
//
//  Created by Andre Pham on 24/10/2022.
//

import XCTest
@testable import yonder

final class PricingTests: XCTestCase {

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
        Pricing.instance.injectStage(1)
        let price1 = buff.getValue(whenTargeting: .player)
        Pricing.instance.injectStage(5)
        let price2 = buff.getValue(whenTargeting: .player)
        XCTAssertTrue(price1 < price2)
    }
    
    func testBalance() throws {
        print("========== PRICING BALANCE REPORT ==========")
        
        print("========== END OF REPORT ===================")
    }

}
