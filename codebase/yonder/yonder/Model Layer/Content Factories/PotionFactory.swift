//
//  PotionFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class PotionFactory {
    
    private let stage: Int
    private var potionSupply = [Potion]()
    
    init(stage: Int) {
        self.stage = stage
    }
    
    private func buildPotions(stage: Int) {
        var potions = [Potion]()
        var weights: [Int]
        
        // Health restoration
        weights = FactoryUtil.createLinearSequence(start: 50, end: 10, count: HealthRestorationPotion.Tier.allCases.count)
        self.shiftWeights(weights: &weights)
        potions.populate(count: 20) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 5)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = HealthRestorationPotion.Tier.allCases[index]
            return HealthRestorationPotion(tier: tier, potionCount: potionCount)
        }
        
        // Max restoration
        potions.populate(count: 3) {
            let potionCount = Random.selectFromNormalDistribution(min: 1, max: 2)
            return MaxRestorationPotion(potionCount: potionCount)
        }
        
        // Damage
        weights = FactoryUtil.createLinearSequence(start: 50, end: 10, count: DamagePotion.Tier.allCases.count)
        self.shiftWeights(weights: &weights)
        potions.populate(count: 20) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 5)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = DamagePotion.Tier.allCases[index]
            return DamagePotion(tier: tier, potionCount: potionCount)
        }
        
        // Max health restoration
        potions.populate(count: 6) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            return MaxHealthRestorationPotion(potionCount: potionCount)
        }
        
        // Damage percent
        weights = FactoryUtil.createLinearSequence(start: 50, end: 30, count: DamagePercentBuffPotion.Tier.allCases.count)
        // (Because percentage scales, no weight shifting is applied)
        potions.populate(count: 3) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = DamagePercentBuffPotion.Tier.allCases[index]
            return DamagePercentBuffPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        }
        
        // Health restoration percent
        weights = FactoryUtil.createLinearSequence(start: 50, end: 30, count: HealthRestorationPercentBuffPotion.Tier.allCases.count)
        // (Because percentage scales, no weight shifting is applied)
        potions.populate(count: 3) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = HealthRestorationPercentBuffPotion.Tier.allCases[index]
            return HealthRestorationPercentBuffPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        }
        
        // Weakness
        weights = FactoryUtil.createLinearSequence(start: 50, end: 30, count: WeaknessPotion.Tier.allCases.count)
        // (Because percentage scales, no weight shifting is applied)
        potions.populate(count: 3) {
            let potionCount = Random.selectFromNormalDistribution(min: 2, max: 3)
            let potionDuration = Random.selectFromNormalDistribution(min: 2, max: 3)
            let index = FactoryUtil.randomWeightedIndex(weights)
            let tier = WeaknessPotion.Tier.allCases[index]
            return WeaknessPotion(tier: tier, duration: potionDuration, potionCount: potionCount)
        }
        
        potions.shuffle()
        self.potionSupply.append(contentsOf: potions)
    }
    
    /// Shifts the weights in an array so that stronger potions appear more frequently in later stages.
    /// Example:
    /// ``` // (self.stage = 7)
    ///     var weights = [50, 40, 30, 20, 10]
    ///     shiftWeights(weights: &weights)
    ///     // weights = [29, 26, 30, 34, 31]
    /// ```
    /// - Parameters:
    ///   - weights: The weights to be shifted (favouring the right)
    private func shiftWeights(weights: inout [Int]) {
        let maxAdjustment = Int(floor(Double(weights.count)/2) + 1)
        var movingAdjustment = maxAdjustment
        var index = 0
        while movingAdjustment >= 1 {
            weights[index] -= movingAdjustment*self.stage
            movingAdjustment -= 1
            index += 1
        }
        movingAdjustment = maxAdjustment
        index = weights.count-1
        while movingAdjustment >= 1 {
            weights[index] += movingAdjustment*self.stage
            movingAdjustment -= 1
            index -= 1
        }
    }
    
    func deliver() -> Potion {
        guard !self.potionSupply.isEmpty else {
            self.buildPotions(stage: self.stage)
        }
        return self.potionSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Potion] {
        guard self.potionSupply.count >= count else {
            self.buildPotions(stage: self.stage)
        }
        return self.potionSupply.dropLast(count)
    }
    
}
