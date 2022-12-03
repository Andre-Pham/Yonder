//
//  PurchaseWeaponOffer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class PurchaseWeaponOffer: Offer {
    
    public let weapon: Weapon
    public let price: Int
    
    init(weapon: Weapon, price: Int) {
        self.weapon = weapon
        self.price = price
        super.init(
            name: Strings("offer.weaponPurchase.name").local,
            description: Strings("offer.weaponPurchase.description2Param").localWithArgs(String(price), weapon.fullSummary)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case weapon
        case price
    }

    required init(dataObject: DataObject) {
        self.weapon = dataObject.getObject(Field.weapon.rawValue, type: Weapon.self)
        self.price = dataObject.get(Field.price.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.weapon.rawValue, value: self.weapon)
            .add(key: Field.price.rawValue, value: self.price)
    }

    // MARK: - Functions
    
    func acceptOffer(player: Player) {
        player.modifyGoldAdjusted(by: -self.price)
        player.addWeapon(self.weapon)
    }
    
    func meetsOfferRequirements(player: Player) -> Bool {
        return player.canAfford(price: self.price)
    }
    
}
