//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoHeadArmor: ArmorAbstract {
    
    let type: ArmorType = .head
    public private(set) var armorPoints: Int = 0
    public private(set) var armorBuffs = [BuffAbstract]()
    
}

class NoBodyArmor: ArmorAbstract {
    
    let type: ArmorType = .body
    public private(set) var armorPoints: Int = 0
    public private(set) var armorBuffs = [BuffAbstract]()
    
}

class NoLegsArmor: ArmorAbstract {
    
    let type: ArmorType = .legs
    public private(set) var armorPoints: Int = 0
    public private(set) var armorBuffs = [BuffAbstract]()
    
}
