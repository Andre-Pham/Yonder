//
//  NoLootOptions.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation

class NoLootOptions: LootOptions {
    
    init() {
        super.init([])
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
