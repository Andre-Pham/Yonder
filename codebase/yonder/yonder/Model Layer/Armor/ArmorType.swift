//
//  ArmorType.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation

enum ArmorType {
    
    case head
    case body
    case legs
    
    var name: String {
        switch self {
        case .head:
            return Strings.Armor.ArmorType.Head.Name.local
        case .body:
            return Strings.Armor.ArmorType.Body.Name.local
        case .legs:
            return Strings.Armor.ArmorType.Legs.Name.local
        }
    }
    
}
