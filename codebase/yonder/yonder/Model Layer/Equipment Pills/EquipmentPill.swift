//
//  EquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

typealias EquipmentPill = EquipmentPillAbstract & HasPriceValue

class EquipmentPillAbstract: Clonable {
    
    private(set) var sourceName: String
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
    
    func updateSource(to sourceName: String) {
        self.sourceName = sourceName
    }
    
}
