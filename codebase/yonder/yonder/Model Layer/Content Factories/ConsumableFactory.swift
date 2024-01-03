//
//  ConsumableFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ConsumableFactory: BuildTokenFactory {
    
    enum BuildToken: String {
        case randomHealth
        case multiplyGold
        case bonusHealth
        case ripeningHealth
        case travelImprovingRestoration
        case restoreArmorPoints
        case damageBuffAll
        case maxRestoreAll
    }
    
    private let stage: Int
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int) {
        self.stage = stage
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 bonus health consumables, etc., in a row
        newTokens.populate(count: 2, { .randomHealth })
        newTokens.populate(count: 2, { .multiplyGold })
        newTokens.populate(count: 6, { .bonusHealth })
        newTokens.populate(count: 2, { .ripeningHealth })
        newTokens.populate(count: 2, { .travelImprovingRestoration })
        newTokens.populate(count: 20, { .restoreArmorPoints })
        newTokens.populate(count: 2, { .damageBuffAll })
        newTokens.populate(count: 2, { .maxRestoreAll })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createConsumable() -> Consumable {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .randomHealth:
            return RandomHealthConsumable(amount: 1)
        case .multiplyGold:
            let goldFraction = Random.selectFromLinearDistribution(min: 1.4, max: 2.0, minY: 10, maxY: 2).nearest(0.2)
            return MultiplyGoldConsumable(goldFraction: goldFraction, amount: 1)
        case .bonusHealth:
            var weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 10, count: BonusHealthConsumable.Tier.allCases.count)
            FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = BonusHealthConsumable.Tier.allCases[index]
            return BonusHealthConsumable(tier: tier, amount: 1)
        case .ripeningHealth:
            let amount = Int.random(in: 1...3)
            return RipeningSetHealthConsumable(amount: amount)
        case .travelImprovingRestoration:
            let amount = Int.random(in: 1...3)
            return TravelImprovingRestorationConsumable(amount: amount)
        case .restoreArmorPoints:
            var weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 10, count: RestoreArmorPointsConsumable.Tier.allCases.count)
            FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = RestoreArmorPointsConsumable.Tier.allCases[index]
            let amount = Random.selectFromNormalDistribution(min: 2, max: 5)
            return RestoreArmorPointsConsumable(tier: tier, amount: amount)
        case .damageBuffAll:
            let tier = DamageBuffAllConsumable.Tier.allCases.randomElement()!
            let amount = Int.random(in: 1...2)
            return DamageBuffAllConsumable(tier: tier, amount: amount)
        case .maxRestoreAll:
            let amount = Int.random(in: 1...2)
            return MaxRestoreAllConsumable(amount: amount)
        }
    }
    
    func deliver() -> Consumable {
        return self.createConsumable()
    }
    
    func deliver(count: Int) -> [Consumable] {
        return Array(count: count, populateWith: self.createConsumable())
    }
    
}
