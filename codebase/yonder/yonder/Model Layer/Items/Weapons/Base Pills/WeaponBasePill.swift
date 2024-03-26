//
//  WeaponBasePill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that initialises weapon properties, for example providing a healing value.
/// Weapons can only take one of this pill.
typealias WeaponBasePill = WeaponBasePillAbstract & WeaponBasePillProtocol

protocol WeaponBasePillProtocol: HasPurchasablePrice {
    
    var effectsDescription: String? { get }
    var previewEffectsDescription: String? { get }
    
    func setup(weapon: Weapon)
    
}

class WeaponBasePillAbstract: Clonable, Storable {
    
    public let id = UUID()
    
    init() { }
    
    required init(_ original: WeaponBasePillAbstract) { }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) { }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
    }
    
}
