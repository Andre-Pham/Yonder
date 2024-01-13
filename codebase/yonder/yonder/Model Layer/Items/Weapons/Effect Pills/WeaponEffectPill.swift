//
//  WeaponEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

/// Pill that provides the weapon with additional effects, such as providing buffs.
typealias WeaponEffectPill = WeaponEffectPillAbstract & WeaponEffectPillProtocol

protocol WeaponEffectPillProtocol: HasPurchasablePrice {
    
    var effectsDescription: String { get }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract)
    
}

class WeaponEffectPillAbstract: Clonable, Storable {
    
    public let id = UUID()
    
    init() { }
    
    required init(_ original: WeaponEffectPillAbstract) { }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) { }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
    }
    
    // MARK: - Functions
    
    /// Override this in subclasses if desired to trigger behaviour upon being equipped
    func onEquip(weapon: Weapon) { }
    
}
