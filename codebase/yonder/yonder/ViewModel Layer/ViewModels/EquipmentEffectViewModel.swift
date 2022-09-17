//
//  EquipmentEffectViewModel.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class EquipmentEffectViewModel: ObservableObject {
    
    private(set) var equipmentPill: EquipmentPill
    
    public let sourceName: String
    public let effectsDescription: String
    public let id: UUID
    
    init(_ equipmentPill: EquipmentPill) {
        self.equipmentPill = equipmentPill
        
        self.sourceName = equipmentPill.sourceName
        self.effectsDescription = equipmentPill.effectsDescription
        self.id = equipmentPill.id
    }
    
}
