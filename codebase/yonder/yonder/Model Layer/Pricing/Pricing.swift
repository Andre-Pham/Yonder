//
//  Pricing.swift
//  yonder
//
//  Created by Andre Pham on 27/9/2022.
//

import Foundation

class Pricing {
    
    // MARK: - Singleton
    
    private(set) static var instance: Pricing = Pricing()
    private(set) var gameContext: GameContext? = nil
    var stage: Int {
        return self.gameContext?.stage ?? 0
    }
    
    private init() { }
    
    func setGameContext(to gameContext: GameContext) {
        self.gameContext = gameContext
    }
    
    // MARK: - Stat Type
    
    class Stat {
        
        /// Value of one unit of the stat, e.g. 1 damage = 1 gold
        public let value: Double
        /// Base stat to base prices off
        public let baseStat: Double
        public var baseStatAmount: Int {
            let stage = Pricing.instance.stage
            return Int(self.baseStat*pow(self.stageMultiplier, Double(stage)))
        }
        /// How much base stats are expected to increase per stage, e.g. health is expected to increase by ~20% per stage
        public let stageMultiplier: Double
        /// The direction where increasing this stat benefits the player, e.g. player damage is .outgoing, foe damage is .incoming
        /// `nil` indicates buffs can't be applied to this stat
        public let playerPrefers: Buff.BuffDirection?
        
        init(value: Double, baseStat: Double, stageMultiplier: Double, playerPrefers: Buff.BuffDirection?) {
            self.value = value
            self.baseStat = baseStat
            self.stageMultiplier = stageMultiplier
            self.playerPrefers = playerPrefers
        }
        
        /// Get the value of a certain amount of a stat.
        /// E.g. a potion does 200 damage, and has 2 uses, this returns the value of 200 damage x2.
        /// Accessories don't have "uses", but the price is baked into bonus health and armor points, so uses should be left to default.
        /// - Parameters:
        ///   - amount: The number of units of the stat, e.g. 5 damage
        ///   - uses: A multiplier for the amount, e.g. 5 potions will do the 5x the damage as 1 potion
        /// - Returns: The value of the amount of a stat
        func getValue(amount: Int, uses: Int = 1) -> Int {
            let stage = Pricing.instance.stage
            return uses*(Double(amount)*self.value*pow(self.stageMultiplier, Double(stage))).toRoundedInt()
        }
        
    }
    
    // MARK: - Utility Implementation
    
    /// Value is multiplied by duration, but if an item's effect lasts forever (e.g. an accessory) it has a flat multipler
    private static let infiniteDuration = 30
    
    /// When no stat applies
    static let noStat = Stat(value: 0.0, baseStat: 0.0, stageMultiplier: 0.0, playerPrefers: nil)
    
    /// Damage dealt by the player
    static let playerDamageStat = Stat(value: 1.0, baseStat: 100.0, stageMultiplier: 1.2, playerPrefers: .outgoing)
    /// Health restoration towards the player
    static let playerHealthRestorationStat = Stat(value: 0.5, baseStat: 200.0, stageMultiplier: 1.2, playerPrefers: .incoming)
    /// Armor points restoration towards the player
    static let playerArmorPointsRestorationStat = Stat(value: 0.5, baseStat: 200.0, stageMultiplier: 1.2, playerPrefers: .incoming)
    /// Bonus health (e.g. an accessory that gives +10 bonus health while equipped)
    static let playerHealthStat = Stat(value: 3.0, baseStat: 200.0, stageMultiplier: 1.2, playerPrefers: nil)
    /// Armor points (e.g. an accessory or armor that gives +10 armor points)
    static let playerArmorPointsStat = Stat(value: 3.0, baseStat: 300.0, stageMultiplier: 1.5, playerPrefers: nil)
    /// Permanent health for the player
    static let playerPermanentHealthStat = Stat(value: 6.0, baseStat: 200.0, stageMultiplier: 1.2, playerPrefers: nil)
    /// Gold owned by player
    static let playerGoldStat = Stat(value: 1.0, baseStat: 1000.0, stageMultiplier: 1.2, playerPrefers: nil)
    
    /// Foe health, for example, if an item halved a foe's health and it was used at stage 0, its value would be $1 x 200.0 / 2, equal to $100
    static let foeHealthStat = Stat(value: 1.0, baseStat: 200.0, stageMultiplier: 1.2, playerPrefers: nil)
    /// Foe armor points
    static let foeArmorPointsStat = Stat(value: 1.0, baseStat: 50.0, stageMultiplier: 1.2, playerPrefers: nil)
    /// Foe damage dealt to player
    static let foeDamageStat = Stat(value: 0.5, baseStat: 75.0, stageMultiplier: 1.1, playerPrefers: .incoming)
    /// Foe health restoration
    static let foeHealthRestorationStat = Stat(value: 1.0, baseStat: 0.0, stageMultiplier: 0.0, playerPrefers: .outgoing)
    /// Foe health restoration
    static let foeArmorPointsRestorationStat = Stat(value: 1.0, baseStat: 0.0, stageMultiplier: 0.0, playerPrefers: .outgoing)
    
    /// Gold received by player from looting, etc.
    static let receivedGoldStat = Stat(value: 1.0, baseStat: 150.0, stageMultiplier: 1.05, playerPrefers: .incoming)
    /// Gold paid out by player
    /// Prices can't be .outgoing, however if the fraction decreases prices we need the player preference to also be unaligned with the buff direction, hence .outgoing is necessary
    static let priceStat = Stat(value: 1.0, baseStat: 50.0, stageMultiplier: 1.1, playerPrefers: .outgoing)
    
    static func getBuffValue(
        flipIncomingOutgoing: Bool,
        incomingStat: Stat,
        outgoingStat: Stat,
        fraction: Double,
        duration: Int?,
        direction: Buff.BuffDirection
    ) -> Int {
        let incomingStat: Stat = flipIncomingOutgoing ? outgoingStat : incomingStat
        let outgoingStat: Stat = flipIncomingOutgoing ? incomingStat : outgoingStat
        
        let stat: Stat
        switch direction {
        case .incoming:
            stat = incomingStat
        case .outgoing:
            stat = outgoingStat
        case .bidirectional:
            stat = outgoingStat
        }
        
        // E.g. .outgoing is preferred when there's an increase in player damage
        let preferenceDirectionAlignsWithIncrease = stat.playerPrefers == direction && fraction.multiplyingIncreases()
        // E.g. .incoming is preferred when there's a decrease in player damage
        let preferenceDirectionAlignsWithDecrease = stat.playerPrefers != direction && fraction.multiplyingDecreases()
        
        let stage = Pricing.instance.stage
        let sign = (preferenceDirectionAlignsWithIncrease || preferenceDirectionAlignsWithDecrease) ? 1 : -1
        return sign*(stat.baseStat*abs(1.0 - fraction)*stat.value*(Double(duration ?? Self.infiniteDuration))*pow(stat.stageMultiplier, Double(stage))).toRoundedInt()
    }
    
    static func getBuffValue(
        flipIncomingOutgoing: Bool,
        incomingStat: Stat,
        outgoingStat: Stat,
        amount: Int,
        duration: Int?,
        direction: Buff.BuffDirection
    ) -> Int {
        let incomingStat: Stat = flipIncomingOutgoing ? outgoingStat : incomingStat
        let outgoingStat: Stat = flipIncomingOutgoing ? incomingStat : outgoingStat
        
        let stat: Stat
        switch direction {
        case .incoming:
            stat = incomingStat
        case .outgoing:
            stat = outgoingStat
        case .bidirectional:
            stat = outgoingStat
        }
        
        // E.g. .outgoing is preferred when there's an increase in player damage
        let preferenceDirectionAlignsWithIncrease = stat.playerPrefers == direction && amount > 0
        // E.g. .incoming is preferred when there's a decrease in player damage
        let preferenceDirectionAlignsWithDecrease = stat.playerPrefers != direction && amount < 0
        
        let stage = Pricing.instance.stage
        let sign = (preferenceDirectionAlignsWithIncrease || preferenceDirectionAlignsWithDecrease) ? 1 : -1
        return sign*(Double(amount)*stat.value*Double(duration ?? Self.infiniteDuration)*pow(stat.stageMultiplier, Double(stage))).toRoundedInt()
    }
    
}
