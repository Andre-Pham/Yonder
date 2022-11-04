//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: Armor {
    
    init(type: ArmorType) {
        let description: String
        switch type {
        case .head:
            description = Strings("armor.noArmor.headDescription").local
        case .body:
            description = Strings("armor.noArmor.bodyDescription").local
        case .legs:
            description = Strings("armor.noArmor.legsDescription").local
        }
        
        super.init(
            name: Strings("armor.noArmor.name").local,
            description: description,
            type: type,
            armorPoints: 0,
            armorBuffs: [],
            equipmentPills: [],
            armorAttributes: [.upgradesDisallowed])
    }
    
    required init(_ original: Armor) {
        super.init(original)
    }
    
}
