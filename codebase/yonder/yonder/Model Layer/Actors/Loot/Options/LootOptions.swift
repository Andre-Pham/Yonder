//
//  LootOptions.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LootOptions: Storable {
    
    private(set) var lootBags: [LootBag]
    @DidSetPublished private(set) var isLooted = false
    
    init(_ options: [LootBag]) {
        self.lootBags = options
        
        self.ensureNameUniqueness()
    }
    
    convenience init(_ options: LootBag...) {
        self.init(options)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case lootBags
        case isLooted
    }

    required init(dataObject: DataObject) {
        self.lootBags = dataObject.getObjectArray(Field.lootBags.rawValue, type: LootBag.self)
        self.isLooted = dataObject.get(Field.isLooted.rawValue, onFail: false)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.lootBags.rawValue, value: self.lootBags)
            .add(key: Field.isLooted.rawValue, value: self.isLooted)
    }

    // MARK: - Functions
    
    /// Ensures all loot bag names are unique. Reassigns names as necessary.
    private func ensureNameUniqueness() {
        var takenNames = [String]()
        for bag in self.lootBags {
            if takenNames.contains(bag.name) {
                bag.reassignName(banned: takenNames)
                takenNames.append(bag.name)
            } else {
                takenNames.append(bag.name)
            }
        }
    }
    
    func take(_ option: UUID, player: Player) {
        if let loot = self.lootBags.first(where: { $0.id == option }) {
            player.setLoot(to: loot)
            self.isLooted = true
        } else {
            assertionFailure("Player is trying to select loot that doesn't exist")
        }
    }
    
}
