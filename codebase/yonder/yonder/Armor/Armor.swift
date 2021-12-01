//
//  Armor.swift
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

typealias ArmorAbstract = ArmorAbstractPart & Purchasable

protocol ArmorAbstractPart {
    
    var type: ArmorType { get }
    var armorPoints: Int { get }
    var armorBuffs: [BuffAbstract] { get }
    
}
