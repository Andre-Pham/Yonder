//
//  AllArmors.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

enum Armors {
    
    // MARK: - No Armor
    
    // Empty armor slots
    static func newNoHeadArmor() -> NoArmor {
        return NoArmor(type: .head)
    }
    static func newNoBodyArmor() -> NoArmor {
        return NoArmor(type: .body)
    }
    static func newNoLegsArmor() -> NoArmor {
        return NoArmor(type: .legs)
    }
    
    // MARK: - Resistance Armor
    
    // Test armor set
    static func newTestHeadArmor() -> ResistanceArmor {
        return ResistanceArmor(type: .head, armorPoints: 200, damageFraction: 0.8, basePurchasePrice: 200)
    }
    static func newTestBodyArmor() -> ResistanceArmor {
        return ResistanceArmor(type: .body, armorPoints: 200, damageFraction: 0.8, basePurchasePrice: 200)
    }
    static func newTestLegsArmor() -> ResistanceArmor {
        return ResistanceArmor(type: .legs, armorPoints: 200, damageFraction: 0.8, basePurchasePrice: 200)
    }
    
    // Future sets follow the naming scheme, e.g. "newFireBreathHeadArmor"
    
}
