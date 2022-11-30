//
//  ConsumableFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ConsumableFactory {
    
    private let stage: Int
    private var consumableSupply = [Consumable]()
    
    init(stage: Int) {
        self.stage = stage
    }
    
    private func buildConsumables() {
        var consumables = [Consumable]()
        var weights: [Int]
        
        // Random health
        consumables.populate(count: 2) {
            return RandomHealthConsumable(amount: 1)
        }
        
        // Multiply gold
        consumables.populate(count: 2) {
            let goldFraction = Random.selectFromLinearDistribution(min: 1.4, max: 2.0, minY: 10, maxY: 2).nearest(0.2)
            return MultiplyGoldConsumable(goldFraction: goldFraction, amount: 1)
        }
        
        // Bonus health
        weights = FactoryUtil.createLinearSequence(start: 50, end: 10, count: BonusHealthConsumable.Tier.allCases.count)
        FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
        consumables.populate(count: 6) {
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = BonusHealthConsumable.Tier.allCases[index]
            return BonusHealthConsumable(tier: tier, amount: 1)
        }
        
        // Ripening health
        consumables.populate(count: 2) {
            let amount = Int.random(in: 1...3)
            return RipeningSetHealthConsumable(amount: amount)
        }
        
        // Travel improving restoration
        consumables.populate(count: 2) {
            let amount = Int.random(in: 1...3)
            return TravelImprovingRestorationConsumable(amount: amount)
        }
        
        // Restore armor points
        weights = FactoryUtil.createLinearSequence(start: 50, end: 10, count: RestoreArmorPointsConsumable.Tier.allCases.count)
        FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
        consumables.populate(count: 20) {
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = RestoreArmorPointsConsumable.Tier.allCases[index]
            let amount = Random.selectFromNormalDistribution(min: 2, max: 5)
            return RestoreArmorPointsConsumable(tier: tier, amount: amount)
        }
        
        // Damage buff all
        consumables.populate(count: 2) {
            let tier = DamageBuffAllConsumable.Tier.allCases.randomElement()!
            let amount = Int.random(in: 1...2)
            return DamageBuffAllConsumable(tier: tier, amount: amount)
        }
        
        // Max restore all
        consumables.populate(count: 2) {
            let amount = Int.random(in: 1...2)
            return MaxRestoreAllConsumable(amount: amount)
        }
        
        consumables.shuffle()
        self.consumableSupply.appendToFront(contentsOf: consumables)
    }
    
    func deliver() -> Consumable {
        if self.consumableSupply.isEmpty {
            self.buildConsumables()
        }
        return self.consumableSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Consumable] {
        let initialCount = self.consumableSupply.count
        while self.consumableSupply.count < count {
            self.buildConsumables()
            assert(initialCount < self.consumableSupply.count, "No consumables being generated - infinite loop")
        }
        return self.consumableSupply.takeLast(count)
    }
    
}
