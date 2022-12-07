//
//  BuffProxy.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

/// A buff that has no effect. Inserted to show up as an ongoing effect, for instance if a specific foe type has a special effect triggered via its weapon.
class BuffProxy: Buff {
    
    /// - Parameters:
    ///   - sourceName: The name of the source causing the buff
    ///   - effectsDescription: Description of the buff's "effects"
    ///   - type: Buff type (does nothing, but could be used as an indicator in future)
    ///   - direction: Buff direction (does nothing, but could be used as an indicator in future)
    init(sourceName: String, effectsDescription: String, type: BuffType, direction: BuffDirection) {
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription,
            duration: nil,
            type: type,
            direction: direction,
            priority: .second
        )
    }
    
    required init(_ original: BuffAbstract) {
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    func getValue(whenTargeting target: Target) -> Int {
        return 0
    }
    
}
