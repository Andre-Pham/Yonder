//
//  EquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

typealias EquipmentPill = EquipmentPillAbstract & HasPriceValue

class EquipmentPillAbstract: Clonable, Storable {
    
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
    
    // MARK: - Serialisation

    private enum Field: String {
        case sourceName
        case effectsDescription
    }

    required init(dataObject: DataObject) {
        self.sourceName = dataObject.get(Field.sourceName.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.sourceName.rawValue, value: self.sourceName)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }

    // MARK: - Functions
    
    func updateSource(to sourceName: String) {
        self.sourceName = sourceName
    }
    
}
