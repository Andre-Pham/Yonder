//
//  NoArmor.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

class NoArmor: ArmorAbstract {
    
    init(type: ArmorType) {
        super.init(
            name: Term.none.capitalized,
            description: "No \(Term.armorSlot(of: type)) \(Term.armor) equipped.",
            type: type,
            armorPoints: 0,
            basePurchasePrice: 0,
            armorBuffs: [],
            armorAttributes: [.upgradesDisallowed])
    }
    
}
