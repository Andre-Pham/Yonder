//
//  Foe.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Foe: ActorAbstract, Named, Described {
    
    /// The ID that indicates what content (sprite sheet and metadata) to use to represent this foe, e.g. E0001
    public let contentID: String?
    public let name: String
    public let description: String
    private(set) var typeName: String? = nil
    private(set) var typeImageResource: ImageResource? = nil
    private(set) var typeDescription: String? = nil
    public let loot: LootOptions
    var canBeLooted: Bool {
        return self.isDead && !self.loot.isLooted
    }
    
    init(
        contentID: String?,
        name: String = "placeholderName",
        description: String = "placeholderDescription",
        maxHealth: Int,
        weapon: Weapon,
        loot: LootOptions
    ) {
        self.contentID = contentID
        self.name = name
        self.description = description
        self.loot = loot
        
        super.init(maxHealth: maxHealth)
        
        self.addWeapon(weapon)
        self.initFoeType()
    }
    
    /// Override this in subclasses to instantiate a foe type.
    func initFoeType() { }
    
    // MARK: - Serialisation

    private enum Field: String {
        case contentID
        case name
        case description
        case loot
    }

    required init(dataObject: DataObject) {
        self.contentID = dataObject.get(Field.contentID.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.loot = dataObject.getObject(Field.loot.rawValue, type: LootOptions.self)
        
        super.init(dataObject: dataObject)
        
        self.initFoeType()
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.contentID.rawValue, value: self.contentID)
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
    
    func setType(name: String, description: String, imageResource: ImageResource) {
        self.typeName = name
        self.typeDescription = description
        self.typeImageResource = imageResource
    }
    
}
