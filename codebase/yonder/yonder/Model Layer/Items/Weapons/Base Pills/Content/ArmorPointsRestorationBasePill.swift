//
//  ArmorPointsRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import Foundation

class ArmorPointsRestorationBasePill: WeaponBasePill {
    
    private(set) var armorPointsRestoration: Int
    public let effectsDescription: String? = nil
    
    init(armorPointsRestoration: Int) {
        self.armorPointsRestoration = armorPointsRestoration
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.armorPointsRestoration = original.armorPointsRestoration
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case armorPointsRestoration
    }

    required init(dataObject: DataObject) {
        self.armorPointsRestoration = dataObject.get(Field.armorPointsRestoration.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.armorPointsRestoration.rawValue, value: self.armorPointsRestoration)
    }

    // MARK: - Functions
    
    func setup(weapon: Weapon) {
        weapon.setArmorPointsRestoration(to: self.armorPointsRestoration)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerArmorPointsRestorationStat.getValue(amount: self.armorPointsRestoration)
    }
    
}
