//
//  AccessoryBuffEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 27/11/2022.
//

import Foundation

class AccessoryBuffEnhanceOffer: EnhanceOffer {
    
    private let buff: Buff
    
    init(price: Int, buff: Buff) {
        self.buff = buff
        super.init(
            price: price,
            name: Strings("enhanceOffer.accessoryBuff.name").local,
            description: Strings("enhanceOffer.accessoryBuff.name").localWithArgs(buff.getEffectsDescription()!)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case buff
    }

    required init(dataObject: DataObject) {
        self.buff = dataObject.getObject(Field.buff.rawValue, type: BuffAbstract.self) as! any Buff
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.buff.rawValue, value: self.buff)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.accessorySlots.allAccessories
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let accessory = player.accessorySlots.allAccessories.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            accessory.addBuff(buff: self.buff)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
