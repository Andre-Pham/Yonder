//
//  EquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

typealias EquipmentPillAbstract = EquipmentPillAbstractPart & HasPriceValue

protocol HasPriceValue {
    
    func getValue() -> Int
    
}

class EquipmentPillAbstractPart: Clonable {
    
    public let effectsDescription: String
    public let id = UUID()
    
    init(effectsDescription: String) {
        self.effectsDescription = effectsDescription
    }
    
    required init(_ original: EquipmentPillAbstractPart) {
        self.effectsDescription = original.effectsDescription
    }
    
}
