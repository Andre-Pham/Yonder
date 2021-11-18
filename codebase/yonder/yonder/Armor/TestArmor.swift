//
//  TestArmor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class TestHeadArmor: ArmorAbstract {
    
    let type: ArmorType = .head
    public private(set) var armorPoints: Int = 200
    public private(set) var armorBuffs: [BuffAbstract] = [DamagePercentBuff(duration: INFINITY, damageFraction: 0.8)]
    
}

class TestBodyArmor: ArmorAbstract {
    
    let type: ArmorType = .body
    public private(set) var armorPoints: Int = 200
    public private(set) var armorBuffs: [BuffAbstract] = [DamagePercentBuff(duration: INFINITY, damageFraction: 0.8)]
    
}

class TestLegsArmor: ArmorAbstract {
    
    let type: ArmorType = .legs
    public private(set) var armorPoints: Int = 200
    public private(set) var armorBuffs: [BuffAbstract] = [DamagePercentBuff(duration: INFINITY, damageFraction: 0.8)]
    
}
