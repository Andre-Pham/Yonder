//
//  RegularFoe.swift
//  yonder
//
//  Created by Andre Pham on 7/11/2022.
//

import Foundation

class RegularFoe: Foe {
    
    init(name: String, description: String, maxHealth: Int, damage: Int, loot: LootOptions) {
        super.init(
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: BaseAttack(damage: damage),
            loot: loot
        )
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
}
