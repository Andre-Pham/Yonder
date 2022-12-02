//
//  EffectBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class EffectBasePill: WeaponBasePill {
    
    public let effectsDescription: String? = nil
    
    override init() {
        // This is required to provide an empty initialiser
        super.init()
    }
    
    required init(_ original: WeaponBasePillAbstract) {
        super.init(original)
    }
    
    // MARK: - Serialisation

    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }

    // MARK: - Functions
    
    func setup(weapon: Weapon) {
        // Nothing to setup
    }
    
    func calculateBasePurchasePrice() -> Int {
        return 0
    }
    
}
