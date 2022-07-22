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
    
    public let sourceName: String
    public let effectsDescription: String
    public let id = UUID()
    
    init(sourceName: String, effectsDescription: String) {
        self.sourceName = sourceName
        self.effectsDescription = effectsDescription
    }
    
    required init(_ original: EquipmentPillAbstractPart) {
        self.sourceName = original.sourceName
        self.effectsDescription = original.effectsDescription
    }
    
}
