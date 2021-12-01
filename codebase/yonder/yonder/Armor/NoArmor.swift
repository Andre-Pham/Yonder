//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: ArmorAbstract {
    
    let type: ArmorType
    public private(set) var armorPoints: Int = 0
    public private(set) var armorBuffs = [BuffAbstract]()
    public let basePurchasePrice = 0
    
    init(type: ArmorType) {
        self.type = type
    }
    
}
