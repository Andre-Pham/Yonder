//
//  NoArea.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

class NoArea: Area {
    
    init() {
        super.init(arrangement: .A, locations: [Location](repeating: NoLocation(), count: AreaArrangements.A.locationCount), tags: RegionTagAllocation(tags: (.all, 1)))
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
