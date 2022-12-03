//
//  NoArea.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

class NoArea: Area {
    
    init() {
        super.init(arrangement: .A, locations: [Location](repeating: NoLocation(), count: AreaArrangements.A.locationCount))
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
