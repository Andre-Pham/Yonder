//
//  EndlessBoss.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

class EndlessBoss: Foe {
    
    private let statsFraction: Double
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, statsFraction: Double, lootChoice: LootChoice) {
        self.statsFraction = statsFraction
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: BaseAttack(damage: damage),
            lootChoice: lootChoice
        )
        let accessory = Accessory(
            name: "",
            description: "",
            type: .regular,
            healthBonus: 0,
            armorPointsBonus: 0,
            buffs: [],
            equipmentPills: [
                LimitStatsFoePhoenixEquipmentPill(
                    statsFraction: statsFraction,
                    sourceName: ""
                )
            ]
        )
        self.equipAccessory(accessory, replacing: nil)
    }
    
    override func initBossContent() {
        self.setBossContent(
            hint: Strings("boss.endless.hint").local,
            description: Strings("boss.endless.description1Param").localWithArgs((self.statsFraction*100.0).toString(decimalPlaces: 0))
        )
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case statsFraction
    }

    required init(dataObject: DataObject) {
        self.statsFraction = dataObject.get(Field.statsFraction.rawValue)
        
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.statsFraction.rawValue, value: self.statsFraction)
    }
    
}
