//
//  EquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

typealias EquipmentPill = EquipmentPillAbstract & HasPriceValue

protocol HasPriceValue {
    
    func getValue() -> Int
    
}

class EquipmentPillAbstract: Clonable {
    
    public let sourceName: String
    public let effectsDescription: String
    public let id = UUID()
    
    init(sourceName: String, effectsDescription: String) {
        self.sourceName = sourceName
        self.effectsDescription = effectsDescription
    }
    
    required init(_ original: EquipmentPillAbstract) {
        self.sourceName = original.sourceName
        self.effectsDescription = original.effectsDescription
    }
    
}
