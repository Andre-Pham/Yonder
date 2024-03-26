//
//  InfiniteDurabilityPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class InfiniteDurabilityPill: WeaponDurabilityPill {
    
    public let effectsDescription: String? = nil
    public let previewEffectsDescription: String? = nil
    
    override init() {
        // This is required to provide an empty initialiser
        super.init()
    }
    
    required init(_ original: WeaponDurabilityPillAbstract) {
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
    
    func setupDurability(weapon: Weapon) {
        weapon.setRemainingUses(to: 1)
        weapon.setInfiniteRemainingUses(to: true)
    }
    
    func use(on weapon: Weapon) {
        // Do nothing - weapon has infinite durability
    }

    func calculateBasePurchasePrice() -> Int {
        return 500
    }
    
}
