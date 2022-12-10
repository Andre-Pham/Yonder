//
//  NoItem.swift
//  yonder
//
//  Created by Andre Pham on 15/6/2022.
//

import Foundation

class NoItem: Item {
    
    let triggersEndOfTurn = false
    
    init() {
        super.init(name: "NO_ITEM", description: "NO_ITEM_DESCRIPTION")
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    func getEffectsDescription() -> String? {
        return nil
    }
    
}
