//
//  ArmorPointsEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class ArmorPointsEnhanceOffer: EnhanceOffer {
    
    private let armorPoints: Int
    
    init(price: Int, armorPoints: Int) {
        self.armorPoints = armorPoints
        super.init(
            price: price,
            name: Strings("enhanceOffer.armorPoints.name").local,
            description: Strings("enhanceOffer.armorPoints.description1Param").localWithArgs(armorPoints)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case armorPoints
    }

    required init(dataObject: DataObject) {
        self.armorPoints = dataObject.get(Field.armorPoints.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.armorPoints.rawValue, value: self.armorPoints)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.allUpgradableArmorPieces
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let armor = player.allArmorPieces.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            player.enhanceArmorPoints(of: armor, armorPoints: self.armorPoints)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
