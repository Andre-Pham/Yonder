//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Foe: ActorAbstract, Named, Described {
    
    public let name: String
    public let description: String
    public let loot: LootOptions
    var canBeLooted: Bool {
        return self.isDead && !self.loot.isLooted
    }
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", maxHealth: Int, weapon: Weapon, loot: LootOptions) {
        self.name = name
        self.description = description
        self.loot = loot
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case loot
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.loot = dataObject.getObject(Field.loot.rawValue, type: LootOptions.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.loot.rawValue, value: self.loot)
    }

    // MARK: - Functions
    
    func getWeapon() -> Weapon {
        assert(self.weapons.count == 1, "Foe has more or less than 1 weapon, which shouldn't be possible")
        return self.weapons.first!
    }
    
    func attack(_ player: Player) {
        self.useWeaponWhere(opposition: player, weapon: self.getWeapon())
    }
    
}
