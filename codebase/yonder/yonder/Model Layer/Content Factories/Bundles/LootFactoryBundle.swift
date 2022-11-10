//
//  LootFactoryBundle.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class LootFactoryBundle {
    
    public let weaponFactory: WeaponFactory
    public let potionFactory: PotionFactory
    public let armorFactory: ArmorFactory
    public let accessoryFactory: AccessoryFactory
    public let consumableFactory: ConsumableFactory
    
    init(weapons: WeaponFactory, potions: PotionFactory, armors: ArmorFactory, accessories: AccessoryFactory, consumables: ConsumableFactory) {
        self.weaponFactory = weapons
        self.potionFactory = potions
        self.armorFactory = armors
        self.accessoryFactory = accessories
        self.consumableFactory = consumables
    }
    
}
