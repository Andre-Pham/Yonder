//
//  FreeWeaponOffer.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FreeWeaponOffer: Offer {
    
    public let weapon: Weapon
    
    init(weapon: Weapon) {
        self.weapon = weapon
        super.init(
            name: Strings("offer.freeWeapon.name").local,
            description: Strings("offer.freeWeapon.description1Param").localWithArgs(weapon.fullSummary)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case weapon
    }

    required init(dataObject: DataObject) {
        self.weapon = dataObject.getObject(Field.weapon.rawValue, type: Weapon.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.weapon.rawValue, value: self.weapon)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.addWeapon(self.weapon)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return true
    }
    
}
