//
//  HealthRestorationBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class HealthRestorationBasePill: WeaponBasePill {
    
    private(set) var healthRestoration: Int
    public let effectsDescription: String? = nil
    public let previewEffectsDescription: String? = nil
    
    init(healthRestoration: Int) {
        self.healthRestoration = healthRestoration
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        let original = original as! Self
        self.healthRestoration = original.healthRestoration
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthRestoration
    }

    required init(dataObject: DataObject) {
        self.healthRestoration = dataObject.get(Field.healthRestoration.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthRestoration.rawValue, value: self.healthRestoration)
    }

    // MARK: - Functions
    
    func setup(weapon: Weapon) {
        weapon.setHealthRestoration(to: self.healthRestoration)
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: self.healthRestoration)
    }
    
}
