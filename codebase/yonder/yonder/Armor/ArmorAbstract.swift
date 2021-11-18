//
//  ArmorAbstract.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

enum ArmorType {
    case head
    case body
    case legs
}

class ArmorAbstract {
    
    public let type: ArmorType
    private(set) var maxArmor: Int
    private(set) var armor: Int
    private(set) var armorBuffs: [ArmorBuffAbstract]
    
    init(type: ArmorType, maxArmor: Int, effects: [ArmorBuffAbstract]) {
        self.type = type
        self.maxArmor = maxArmor
        self.armor = maxArmor
        self.armorBuffs = effects
    }
    
}
