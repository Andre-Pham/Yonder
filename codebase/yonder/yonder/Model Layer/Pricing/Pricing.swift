//
//  Pricing.swift
//  yonder
//
//  Created by Andre Pham on 27/9/2022.
//

import Foundation

/// A utility class for managing the pricing of anything and everything to ensure consistency and balance across the game.
class Pricing {
    
    // MARK: - Singleton
    
    private(set) static var instance: Pricing = Pricing()
    private(set) var stageManager: PlayerStageManager? = nil
    private(set) var injectedStage: Int? = nil
    var stage: Int {
        return self.injectedStage ?? (self.stageManager?.stage ?? 0)
    }
    
    private init() { }
    
    func setStageManager(to stageManager: PlayerStageManager) {
        self.stageManager = stageManager
    }
    
    private func injectStage(_ stage: Int?) {
        self.injectedStage = stage
    }
    
    /// Conduct a pricing calculation using a specific stage.
    /// - Parameters:
    ///   - stage: The stage to be used for the calculation
    ///   - calculation: The calculation that uses the stage and returns a value
    /// - Returns: The return value of the passed in calculation
    static func usingStage(stage: Int, _ calculation: () -> Int) -> Int {
        Self.instance.injectStage(stage)
        let result = calculation()
        Self.instance.injectStage(nil)
        return result
    }
    
    // MARK: - Stats
    
    /// Represents a stat that has value and a "base" amount.
    /// Base stats should be the average/expected stat for a stage 0 entity that HAS that stat.
    class Stat {
        
        /// Value of one unit of the stat, e.g. 1 damage = 1 gold
        fileprivate let value: Double
        /// Base stat to base prices off
        fileprivate let baseStat: Double
        /// The base stat to base prices off to be used independently from implemented `Pricing` algorithms, with stage multiplier factored in
        public var baseStatAmount: Int {
            let stage = Pricing.instance.stage
            return (self.baseStat*pow(self.stageMultiplier, Double(stage))).toRoundedInt()
        }
        /// How much base stats are expected to increase per stage, e.g. health is expected to increase by ~20% per stage
        fileprivate let stageMultiplier: Double
        ///
        fileprivate let playerWantsIncreased: Bool
        /// Value is multiplied by duration, but if an item's effect lasts forever (e.g. an accessory) it has a flat multipler
        public static let infiniteDuration = 22
        
        fileprivate init(value: Double, baseStat: Double, stageMultiplier: Double, playerWantsIncreased: Bool) {
            self.value = value
            self.baseStat = baseStat
            self.stageMultiplier = stageMultiplier
            self.playerWantsIncreased = playerWantsIncreased
        }
        
        func fractionOfBaseStatAmount(_ fraction: Double) -> Int {
            let stage = Pricing.instance.stage
            return (self.baseStat*pow(self.stageMultiplier, Double(stage))*fraction).toRoundedInt()
        }
        
        private func getValueSign(statIncreases: Bool) -> Int {
            return (statIncreases == self.playerWantsIncreased) ? 1 : -1
        }
        
        /// Get the value of a certain amount of a stat.
        /// E.g. a potion does 200 damage, and has 2 uses, this returns the value of 200 damage x2.
        /// Accessories don't have "uses", but the price is baked into bonus health and armor points, so uses should be left to default.
        /// - Parameters:
        ///   - amount: The number of units of the stat, e.g. 5 damage
        ///   - uses: A multiplier for the amount, e.g. 5 potions will do the 5x the damage as 1 potion
        /// - Returns: The value of the amount of a stat
        func getValue(amount: Int, uses: Int = 1) -> Int {
            return self.getValueSign(statIncreases: amount > 0)*uses*(Double(amount)*self.value).toRoundedInt()
        }
        
        fileprivate func getBuffValue(fraction: Double, duration: Int?) -> Int {
            let stage = Pricing.instance.stage
            return self.getValueSign(statIncreases: fraction.multiplyingIncreases())*(self.baseStat*abs(1.0 - fraction)*self.value*(Double(duration ?? Self.infiniteDuration))*pow(self.stageMultiplier, Double(stage))).toRoundedInt()
        }
        
        fileprivate func getBuffValue(amount: Int, duration: Int?) -> Int {
            return self.getValueSign(statIncreases: amount > 0)*(Double(abs(amount))*self.value*Double(duration ?? Self.infiniteDuration)).toRoundedInt()
        }
        
    }
    
    // MARK: - Utility Implementation
    
    /// Damage dealt by the player
    static let playerDamageStat = Stat(value: 0.5, baseStat: 75.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    /// Health restoration towards the player
    static let playerHealthRestorationStat = Stat(value: 0.3, baseStat: 150.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    /// Armor points restoration towards the player
    static let playerArmorPointsRestorationStat = Stat(value: 0.3, baseStat: 150.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    /// Bonus health (e.g. an accessory that gives +10 bonus health while equipped)
    static let playerHealthStat = Stat(value: 2.0, baseStat: 150.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    /// Armor points (e.g. an accessory or armor that gives +10 armor points)
    static let playerArmorPointsStat = Stat(value: 3.0, baseStat: 220.0, stageMultiplier: 1.5, playerWantsIncreased: true)
    /// Permanent health for the player
    static let playerPermanentHealthStat = Stat(value: 4.0, baseStat: 160.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    /// Gold owned by player
    static let playerGoldStat = Stat(value: 1.0, baseStat: 600.0, stageMultiplier: 1.2, playerWantsIncreased: true)
    
    /// Foe health
    static let foeHealthStat = Stat(value: 1.0, baseStat: 175.0, stageMultiplier: 1.5, playerWantsIncreased: false)
    /// Foe armor points
    static let foeArmorPointsStat = Stat(value: 1.0, baseStat: 0.0, stageMultiplier: 1.1, playerWantsIncreased: false)
    /// Foe damage dealt to player
    static let foeDamageStat = Stat(value: 0.65, baseStat: 45.0, stageMultiplier: 1.4, playerWantsIncreased: false)
    /// Foe health restoration
    static let foeHealthRestorationStat = Stat(value: 1.0, baseStat: 15.0, stageMultiplier: 1.1, playerWantsIncreased: false)
    /// Foe health restoration
    static let foeArmorPointsRestorationStat = Stat(value: 1.0, baseStat: 15.0, stageMultiplier: 1.1, playerWantsIncreased: false)
    
    /// Gold received by player from looting, etc.
    /// NOTE: This may seem unintuitive - how can 1 gold be worth 0.35 gold??? The answer is, gold-over-time is less valuable than gold now, and why would anyone pay $100 for an accessory that over time will only earn $100
    static let receivedGoldStat = Stat(value: 0.35, baseStat: 130.0, stageMultiplier: 1.05, playerWantsIncreased: true)
    /// Gold paid out by player, e.g. purchasing from a shop.
    /// NOTE: This may seem unintuitive - how can 1 gold be worth 0.35 gold??? The answer is, gold-over-time is less valuable than gold now, and why would anyone pay $100 for an accessory that over time will only earn $100
    static let priceStat = Stat(value: 0.35, baseStat: 100.0, stageMultiplier: 1.1, playerWantsIncreased: false)
    
    private static func selectValue(
        playerValue: Int,
        foeValue: Int,
        target: Target,
        direction: Buff.BuffDirection,
        targetsOwner: Bool
    ) -> Int {
        var usePlayerValue: Bool
        switch direction {
        case .outgoing:
            usePlayerValue = target == .player
        case .incoming:
            usePlayerValue = target == .foe
        case .bidirectional:
            return foeValue + playerValue
        }
        if targetsOwner {
            usePlayerValue.toggle()
        }
        return usePlayerValue ? playerValue : foeValue
    }
    
    static func getTargetedBuffValue(amount: Int, defaultTargetsOwner: Bool, target: Target, playerStat: Stat, foeStat: Stat, timeRemaining: Int?, direction: Buff.BuffDirection) -> Int {
        let playerStatValue = playerStat.getBuffValue(amount: amount, duration: timeRemaining)
        let foeStatValue = foeStat.getBuffValue(amount: amount, duration: timeRemaining)
        return Self.selectValue(
            playerValue: playerStatValue,
            foeValue: foeStatValue,
            target: target,
            direction: direction,
            targetsOwner: defaultTargetsOwner
        )
    }
    
    static func getTargetedBuffValue(fraction: Double, defaultTargetsOwner: Bool, target: Target, playerStat: Stat, foeStat: Stat, timeRemaining: Int?, direction: Buff.BuffDirection) -> Int {
        let playerStatValue = playerStat.getBuffValue(fraction: fraction, duration: timeRemaining)
        let foeStatValue = foeStat.getBuffValue(fraction: fraction, duration: timeRemaining)
        return Self.selectValue(
            playerValue: playerStatValue,
            foeValue: foeStatValue,
            target: target,
            direction: direction,
            targetsOwner: defaultTargetsOwner
        )
    }
    
    static func getBuffValue(amount: Int, stat: Stat, timeRemaining: Int?) -> Int {
        let statValue = stat.getBuffValue(amount: amount, duration: timeRemaining)
        return statValue
    }
    
    static func getBuffValue(fraction: Double, stat: Stat, timeRemaining: Int?) -> Int {
        let statValue = stat.getBuffValue(fraction: fraction, duration: timeRemaining)
        return statValue
    }
    
}
