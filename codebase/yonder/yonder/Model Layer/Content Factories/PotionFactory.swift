//
//  PotionFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class PotionFactory: BuildTokenFactory {
    
    enum BuildToken: String {
        case healthRestoration
        case maxRestoration
        case damage
        case maxHealthRestoration
        case damagePercent
        case healthRestorationPercent
        case weakness
    }
    
    private let stage: Int
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int) {
        self.stage = stage
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 damage potions, etc., in a row
        newTokens.populate(count: 20, { .healthRestoration })
        newTokens.populate(count: 3, { .maxRestoration })
        newTokens.populate(count: 10, { .damage })
        newTokens.populate(count: 6, { .maxHealthRestoration })
        newTokens.populate(count: 1, { .damagePercent })
        newTokens.populate(count: 1, { .healthRestorationPercent })
        newTokens.populate(count: 1, { .weakness })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createPotion() -> Potion {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .healthRestoration:
            var weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 10, count: HealthRestorationPotion.Tier.allCases.count)
            FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = HealthRestorationPotion.Tier.allCases[index]
            return HealthRestorationPotion(tier: tier, potionCount: potionCount)
        case .maxRestoration:
            let potionCount = Random.selectFromNormalDistribution(min: 1, max: 2)
            return MaxRestorationPotion(potionCount: potionCount)
        case .damage:
            var weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 10, count: DamagePotion.Tier.allCases.count)
            FactoryUtil.shiftWeights(stage: self.stage, weights: &weights)
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = DamagePotion.Tier.allCases[index]
            return DamagePotion(tier: tier, potionCount: potionCount)
        case .maxHealthRestoration:
            let potionCount = Random.selectFromNormalDistribution(min: 1, max: 2)
            return MaxHealthRestorationPotion(potionCount: potionCount)
        case .damagePercent:
            let weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 30, count: DamagePercentBuffPotion.Tier.allCases.count)
            // (Because percentage scales, no weight shifting is applied)
            let potionCount = Random.selectFromNormalDistribution(min: 1, max: 2)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = DamagePercentBuffPotion.Tier.allCases[index]
            return DamagePercentBuffPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        case .healthRestorationPercent:
            let weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 30, count: HealthRestorationPercentBuffPotion.Tier.allCases.count)
            // (Because percentage scales, no weight shifting is applied)
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = HealthRestorationPercentBuffPotion.Tier.allCases[index]
            return HealthRestorationPercentBuffPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        case .weakness:
            let weights: [Int] = FactoryUtil.createLinearSequence(start: 50, end: 30, count: WeaknessPotion.Tier.allCases.count)
            // (Because percentage scales, no weight shifting is applied)
            let potionCount = Random.selectFromNormalDistribution(min: 1, max: 2)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = WeaknessPotion.Tier.allCases[index]
            return WeaknessPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        }
    }
    
    func deliver() -> Potion {
        return self.createPotion()
    }
    
    func deliver(count: Int) -> [Potion] {
        return Array(count: count, populateWith: self.createPotion())
    }
    
}
