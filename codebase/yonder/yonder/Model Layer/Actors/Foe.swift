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
    /// The name of the foe
    public let name: String
    /// The flavor description of the foe (descriptive, narrative, or thematic text)
    public let description: String
    /// The name of the foe's type (if applicable)
    private(set) var typeName: String? = nil
    /// The image that represents the foe's type (if applicable)
    private(set) var typeImageResource: YonderImage? = nil
    /// A description of the foe's type; includes the technical aspect of the type, as well as some flavor text for reasoning
    /// E.g. "Brute hostiles are heavy hitters. They deal 2x damage to shields."
    private(set) var typeDescription: String? = nil
    /// A brief hinting of the boss' effects
    /// E.g. "Gains attack every turn!"
    private(set) var bossHint: String? = nil
    /// An extended description of the boss' effects
    /// E.g. "This boss only gets stronger. With every passing turn, their attack increases by 10%."
    private(set) var bossDescription: String? = nil
    /// Regular loot options (pick a loot bag and get everything inside)
    public let loot: LootOptions?
    /// A loot choice (select one piece of loot)
    public let lootChoice: LootChoice?
    /// True if the foe has loot options, and can be looted (is defeated)
    var canBeLooted: Bool {
        if let loot = self.loot {
            return !loot.isLooted && self.isDead
        }
        return false
    }
    /// True if the foe has a loot choice, and can be looted (is defeated)
    var hasLootChoiceAvailable: Bool {
        if let loot = self.lootChoice {
            return !loot.isLooted && self.isDead
        }
        return false
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
        self.lootChoice = nil
        
        super.init(maxHealth: maxHealth)
        
        self.setup(with: weapon)
    }
    
    init(
        contentID: String?,
        name: String = "placeholderName",
        description: String = "placeholderDescription",
        maxHealth: Int,
        weapon: Weapon,
        lootChoice: LootChoice
    ) {
        self.contentID = contentID
        self.name = name
        self.description = description
        self.loot = nil
        self.lootChoice = lootChoice
        
        super.init(maxHealth: maxHealth)
        
        self.setup(with: weapon)
    }
    
    private func setup(with weapon: Weapon) {
        self.addWeapon(weapon)
        self.initFoeType()
        self.initBossContent()
    }
    
    /// Override this in subclasses to instantiate a foe type.
    func initFoeType() { }
    
    /// Override this in subclasses to instantiate the boss content.
    func initBossContent() { }
    
    // MARK: - Serialisation

    private enum Field: String {
        case contentID
        case name
        case description
        case loot
        case lootChoice
    }

    required init(dataObject: DataObject) {
        self.contentID = dataObject.get(Field.contentID.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.loot = dataObject.getObjectOptional(Field.loot.rawValue, type: LootOptions.self)
        self.lootChoice = dataObject.getObjectOptional(Field.lootChoice.rawValue, type: LootChoice.self)
        
        super.init(dataObject: dataObject)
        
        self.initFoeType()
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.contentID.rawValue, value: self.contentID)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.loot.rawValue, value: self.loot)
            .add(key: Field.lootChoice.rawValue, value: self.lootChoice)
    }

    // MARK: - Functions
    
    func getWeapon() -> Weapon {
        assert(self.weapons.count == 1, "Foe has more or less than 1 weapon, which shouldn't be possible")
        return self.weapons.first!
    }
    
    func attack(_ player: Player) {
        self.useWeaponWhere(opposition: player, weapon: self.getWeapon())
    }
    
    func setType(name: String, description: String, imageResource: YonderImage) {
        self.typeName = name
        self.typeDescription = description
        self.typeImageResource = imageResource
    }
    
    func setBossContent(hint: String, description: String) {
        self.bossHint = hint
        self.bossDescription = description
    }
    
}
