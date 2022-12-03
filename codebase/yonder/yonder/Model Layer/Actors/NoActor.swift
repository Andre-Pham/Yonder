//
//  NoActor.swift
//  yonder
//
//  Created by Andre Pham on 15/6/2022.
//

import Foundation

class NoActor: ActorAbstract {
    
    init() {
        super.init(maxHealth: 0)
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
