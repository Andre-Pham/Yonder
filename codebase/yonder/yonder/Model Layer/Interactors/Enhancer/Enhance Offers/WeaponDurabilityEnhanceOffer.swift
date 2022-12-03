//
//  WeaponDurabilityEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponDurabilityEnhanceOffer: EnhanceOffer {
    
    private let amount: Int
    
    init(price: Int, amount: Int) {
        self.amount = amount
        super.init(
            price: price,
            name: Strings("enhanceOffer.weaponDurability.name").local,
            description: Strings("enhanceOffer.weaponDurability.description1Param").localWithArgs(amount)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case amount
    }

    required init(dataObject: DataObject) {
        self.amount = dataObject.get(Field.amount.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.amount.rawValue, value: self.amount)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustRemainingUses(by: self.amount)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
