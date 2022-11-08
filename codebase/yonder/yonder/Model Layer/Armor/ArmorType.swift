//
//  ArmorType.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation

enum ArmorType: CaseIterable {
    
    case head
    case body
    case legs
    
    var name: String {
        switch self {
        case .head:
            return Strings("armor.armorType.head.name").local
        case .body:
            return Strings("armor.armorType.body.name").local
        case .legs:
            return Strings("armor.armorType.legs.name").local
        }
    }
    
}
