//
//  WeaponDamageEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponDamageEnhanceOffer: EnhanceOffer {
    
    private let damage: Int
    
    init(price: Int, damage: Int) {
        self.damage = damage
        super.init(
            price: price,
            name: Strings("enhanceOffer.weaponDamage.name").local,
            description: Strings("enhanceOffer.weaponDamage.description1Param").localWithArgs(damage)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case damage
    }

    required init(dataObject: DataObject) {
        self.damage = dataObject.get(Field.damage.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damage.rawValue, value: self.damage)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons.filter({ $0.damage > 0 })
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.adjustDamage(by: self.damage)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
