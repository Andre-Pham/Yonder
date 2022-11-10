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
    }
    
    private func buildLootBag() -> LootBag {
        let bag = LootBag()
        let targetValue = 800.0.compound(multiply: 1.4, index: self.stage).toRoundedInt()
        let minValue = Random.selectFromNormalDistribution(mid: targetValue, boundFraction: 0.25)
        while bag.totalValue < minValue {
            let toAdd = LootType.allCases.randomElement()!
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
