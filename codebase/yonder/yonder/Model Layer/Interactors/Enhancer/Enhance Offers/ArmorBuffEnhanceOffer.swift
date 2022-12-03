//
//  ArmorBuffEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class ArmorBuffEnhanceOffer: EnhanceOffer {
    
    private let buff: Buff
    
    init(price: Int, buff: Buff) {
        self.buff = buff
        super.init(
            price: price,
            name: Strings("enhanceOffer.armorBuff.name").local,
            description: Strings("enhanceOffer.armorBuff.description1Param").localWithArgs(buff.getEffectsDescription()!)
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
        return player.allUpgradableArmorPieces
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            armor.addBuff(buff: self.buff)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
