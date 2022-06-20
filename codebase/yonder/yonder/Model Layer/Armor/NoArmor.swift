//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: ArmorAbstract {
    
    init(type: ArmorType) {
        let description: String
        switch type {
        case .head:
            description = Strings.Armor.NoArmor.HeadDescription.local
        case .body:
            description = Strings.Armor.NoArmor.BodyDescription.local
        case .legs:
            description = Strings.Armor.NoArmor.LegsDescription.local
        }
        
        super.init(
            name: Strings.Armor.NoArmor.Name.local,
            description: description,
            type: type,
            armorPoints: 0,
            basePurchasePrice: 0,
            armorBuffs: [],
            armorAttributes: [.upgradesDisallowed])
    }
    
}
