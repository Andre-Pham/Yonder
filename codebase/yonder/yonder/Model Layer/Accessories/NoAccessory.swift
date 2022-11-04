//
//  NoAccessory.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class NoAccessory: Accessory {
    
    init(type: AccessoryType) {
        let description: String
        switch type {
        case .regular:
            description = Strings("accessory.noAccessory.regularDescription").local
        case .peripheral:
            description = Strings("accessory.noAccessory.peripheralDescription").local
        }
        
        super.init(
            name: Strings("accessory.noAccessory.name").local,
            description: description,
            type: type,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [])
    }
    
    required init(_ original: Accessory) {
        super.init(original)
    }
    
}
