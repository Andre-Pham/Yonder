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
    public let typeName: String?
    public let typeImageResource: ImageResource?
    public let loot: LootOptions
    var canBeLooted: Bool {
        return self.isDead && !self.loot.isLooted
    }
    
    init(
        name: String = "placeholderName",
        description: String = "placeholderDescription",
        typeName: String? = nil,
        typeImageResource: ImageResource? = nil,
        maxHealth: Int,
        weapon: Weapon,
        loot: LootOptions
    ) {
        self.name = name
        self.description = description
        self.loot = loot
        self.typeName = typeName
        self.typeImageResource = typeImageResource
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case loot
        case typeName
        case typeImageName
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.loot = dataObject.getObject(Field.loot.rawValue, type: LootOptions.self)
        self.typeName = dataObject.get(Field.typeName.rawValue)
        let typeImageName: String? = dataObject.get(Field.typeImageName.rawValue)
        self.typeImageResource = typeImageName == nil ? nil : ImageResource(typeImageName!)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.loot.rawValue, value: self.loot)
            .add(key: Field.typeName.rawValue, value: self.typeName)
            .add(key: Field.typeImageName.rawValue, value: self.typeImageResource?.name)
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
