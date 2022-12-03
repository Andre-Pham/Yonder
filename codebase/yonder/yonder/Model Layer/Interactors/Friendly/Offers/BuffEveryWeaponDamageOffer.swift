//
//  BuffEveryWeaponDamageOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class BuffEveryWeaponDamageOffer: Offer {
    
    public let damage: Int
    
    init(damage: Int) {
        self.damage = damage
        assert(damage > 0, "Negative or 0 damage not permitted")
        super.init(
            name: Strings("offer.buffEveryWeaponDamage.name").local,
            description: Strings("offer.buffEveryWeaponDamage.description1Param").localWithArgs(damage)
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
    
    func acceptOffer(player: Player) {
        for weapon in player.weapons {
            weapon.adjustDamage(by: self.damage)
        }
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return !player.weapons.isEmpty
    }
    
}
