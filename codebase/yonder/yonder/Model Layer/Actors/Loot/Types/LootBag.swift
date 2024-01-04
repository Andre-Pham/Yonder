//
//  LootBag.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

/// Loot bags are made up of pieces of loot (like armors, weapons, etc.) that can all be collected once the loot bag is selected.
class LootBag: Loot {
    
    /// The available names for this loot bag to possibly have
    private static let AVAILABLE_NAMES: [String] = [
        Strings("loot.lootBagName.amber").local,
        Strings("loot.lootBagName.violet").local,
        Strings("loot.lootBagName.ebony").local,
        Strings("loot.lootBagName.rose").local,
        Strings("loot.lootBagName.fern").local,
        Strings("loot.lootBagName.tangerine").local,
        Strings("loot.lootBagName.azure").local,
        Strings("loot.lootBagName.sage").local,
        Strings("loot.lootBagName.midnight").local,
        Strings("loot.lootBagName.cobalt").local,
        Strings("loot.lootBagName.scarlet").local,
        Strings("loot.lootBagName.sangria").local
    ]
    
    /// The loot bag's name
    private(set) var name: String
    /// The total value in gold of everything in the loot bag
    var totalValue: Int {
        var sum = 0
        self.armorLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.weaponLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.potionLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.accessoryLoot.forEach({ sum += $0.getBasePurchasePrice() })
        self.consumableLoot.forEach({ sum += $0.getBasePurchasePrice() })
        sum += self.goldLoot
        return sum
    }
    /// The loot bag's contents description
    var description: String {
        var components = [String]()
        if !self.armorLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.armors").local).rightPadded(by: ":")
                    .continuedBy(String(self.armorLoot.count))
            )
        }
        if !self.accessoryLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.accessories").local).rightPadded(by: ":")
                    .continuedBy(String(self.accessoryLoot.count))
            )
        }
        if !self.weaponLoot.isEmpty {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.weapons").local).rightPadded(by: ":")
                    .continuedBy(String(self.weaponLoot.count))
            )
        }
        if !self.consumableLoot.isEmpty {
            var count = 0
            self.consumableLoot.forEach({ count += $0.remainingUses })
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.consumables").local).rightPadded(by: ":")
                    .continuedBy(String(count))
            )
        }
        if !self.potionLoot.isEmpty {
            var count = 0
            self.potionLoot.forEach({ count += $0.potionCount })
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.potions").local).rightPadded(by: ":")
                    .continuedBy(String(count))
            )
        }
        if self.goldLoot > 0 {
            components.append(
                Strings("dotPoint").local
                    .continuedBy(Strings("loot.category.gold").local).rightPadded(by: ":")
                    .continuedBy(String(self.goldLoot).leftPadded(by: Strings("currencySymbol").local))
            )
        }
        return components.joined(separator: "\n")
    }
    
    override init() {
        self.name = Self.AVAILABLE_NAMES.randomElement()!
        
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
    }
    
    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.name.rawValue, value: self.name)
    }
    
    // MARK: - Functions
    
    func reassignName(banned: [String] = []) {
        let currentIndex = Self.AVAILABLE_NAMES.firstIndex(of: self.name)!
        var newIndex = (currentIndex + Int.random(in: 1..<Self.AVAILABLE_NAMES.count))%Self.AVAILABLE_NAMES.count
        while banned.contains(where: { $0 == Self.AVAILABLE_NAMES[newIndex] }) {
            newIndex = (newIndex + 1)%Self.AVAILABLE_NAMES.count
        }
        self.name = Self.AVAILABLE_NAMES[newIndex]
    }
    
}
