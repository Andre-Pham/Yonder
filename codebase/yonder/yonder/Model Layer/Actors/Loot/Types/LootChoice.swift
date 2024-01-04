//
//  LootChoice.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation

/// Unlike loot bags, where the player takes all the loot in a bag, a loot choice allows the player to only select one piece of loot.
class LootChoice: Loot {
    
    /// True if the player has selected a piece of loot (and hence can't take anything else)
    @DidSetPublished private(set) var isLooted: Bool
    /// True if the player can collect
    /// (Currently acts as a measure of if the player manages to press two "loot" choices before the dismiss animation)
    override var canCollect: Bool {
        return !self.isLooted
    }
    
    override init() {
        self.isLooted = false
        
        super.init()
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case isLooted
    }
    
    required init(dataObject: DataObject) {
        self.isLooted = dataObject.get(Field.isLooted.rawValue, onFail: true)
        
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.isLooted.rawValue, value: self.isLooted)
    }
    
    // MARK: - Functions
    
    override func afterLootCollection() {
        super.afterLootCollection()
        
        self.isLooted = true
    }
    
}
