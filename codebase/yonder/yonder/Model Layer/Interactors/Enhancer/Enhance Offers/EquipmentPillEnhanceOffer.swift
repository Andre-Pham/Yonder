//
//  EquipmentPillEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 26/11/2022.
//

import Foundation

class EquipmentPillEnhanceOffer: EnhanceOffer {
    
    private let pill: EquipmentPill
    
    init(price: Int, pill: EquipmentPill) {
        self.pill = pill
        super.init(
            price: price,
            name: Strings("enhanceOffer.equipmentPill.name").local,
            description: Strings("enhanceOffer.equipmentPill.description1Param").localWithArgs(pill.effectsDescription)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case pill
    }

    required init(dataObject: DataObject) {
        self.pill = dataObject.getObject(Field.pill.rawValue, type: EquipmentPillAbstract.self) as! any EquipmentPill
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.pill.rawValue, value: self.pill)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces + player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        guard self.canBePurchased(price: self.price, purchaser: player) else {
            return
        }
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }) {
            armor.addEquipmentPill(self.pill)
            player.modifyGoldAdjusted(by: -self.price)
        } else if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }) {
            accessory.addEquipmentPill(self.pill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
