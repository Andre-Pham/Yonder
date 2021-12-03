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

class ArmorAbstractPart {
    
    public let type: ArmorType
    private(set) var armorPoints: Int
    private(set) var armorBuffs: [BuffAbstract]
    
    init(type: ArmorType, armorPoints: Int, armorBuffs: [BuffAbstract]) {
        self.type = type
        self.armorPoints = armorPoints
        self.armorBuffs = armorBuffs
    }
    
    func adjustArmorPoints(by armorPoints: Int) {
        self.armorPoints += armorPoints
    }
    
}
