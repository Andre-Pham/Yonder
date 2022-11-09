//
//  AreaFactoryBundle.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaFactoryBundle {
    
    public let weaponFactory: WeaponFactory
    public let potionFactory: PotionFactory
    public let armorFactory: ArmorFactory
    public let accessoryFactory: AccessoryFactory
    public let consumableFactory: ConsumableFactory
    public let foeFactory: FoeFactory
    
    init(weapons: WeaponFactory, potions: PotionFactory, armors: ArmorFactory, accessories: AccessoryFactory, consumables: ConsumableFactory, foes: FoeFactory) {
        self.weaponFactory = weapons
        self.potionFactory = potions
        self.armorFactory = armors
        self.accessoryFactory = accessories
        self.consumableFactory = consumables
        self.foeFactory = foes
    }
    
}
