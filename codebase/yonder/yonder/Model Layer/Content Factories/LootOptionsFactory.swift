//
//  LootOptionsFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class LootOptionsFactory {
    
    private let lootFactories: LootFactoryBundle
    private let stage: Int
    
    init(stage: Int, lootFactories: LootFactoryBundle) {
        self.stage = stage
        self.lootFactories = lootFactories
    }
    
    enum LootType: CaseIterable {
        case gold
        case armor
        case potion
        case weapon
        case accessory
        case consumable
        
        /// The relative weighting to be chosen to be added to a loot bag
        var weight: Int {
            switch self {
            case .gold: return 3
            case .armor: return 2
            case .potion: return 2
            case .weapon: return 2
            case .accessory: return 3
            case .consumable: return 2
            }
        }
    }
    
    private func buildLootBag() -> LootBag {
        let bag = LootBag()
        let targetValue = 250.0.compound(multiply: 1.4, index: self.stage).toRoundedInt()
        let minValue = Random.selectFromNormalDistribution(mid: targetValue, boundFraction: 0.25)
        while bag.totalValue < minValue && bag.optionCount < 3 {
            let lootTypes = LootType.allCases
            let lootTypeWeights: [Int] = lootTypes.map({
                if $0 == .weapon && bag.weaponLoot.count > 0 {
                    // Loot bags are not allowed to contain more than a single weapon
                    return 0
                }
                return $0.weight
            })
            let toAdd = lootTypes[FactoryUtil.randomWeightedIndex(lootTypeWeights)]
            switch toAdd {
            case .gold:
                let targetGold = 200.0.compound(multiply: 1.4, index: self.stage).toRoundedInt()
                let gold = Random.selectFromNormalDistribution(mid: targetGold, boundFraction: 0.5)
                bag.addGoldLoot(gold)
            case .armor:
                bag.addArmorLoot(self.lootFactories.armorFactory.deliver())
            case .potion:
                bag.addPotionLoot(self.lootFactories.potionFactory.deliver())
            case .weapon:
                bag.addWeaponLoot(self.lootFactories.weaponFactory.deliver())
            case .accessory:
                bag.addAccessoryLoot(self.lootFactories.accessoryFactory.deliver())
            case .consumable:
                bag.addConsumableLoot(self.lootFactories.consumableFactory.deliver())
            }
        }
        // Because we want the player to build up gold over time naturally (without having to explicitly collect it), add a bit of gold to most bags
        // It's also fun and thematic to get a bit of gold
        if Random.roll(2, in: 3) {
            let targetGold = 40.0.compound(multiply: 1.4, index: self.stage).toRoundedInt()
            let gold = Random.selectFromNormalDistribution(mid: targetGold, boundFraction: 0.5)
            bag.addGoldLoot(gold)
        }
        return bag
    }
    
    func deliver() -> LootOptions {
        return LootOptions(
            self.buildLootBag(),
            self.buildLootBag(),
            self.buildLootBag()
        )
    }
    
}
