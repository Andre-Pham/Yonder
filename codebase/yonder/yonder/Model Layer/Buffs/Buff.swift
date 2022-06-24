//
//  File.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class BuffAbstract: EffectsDescribed {
    
    private let effectsDescription: String?
    var isInfinite: Bool = false
    var timeRemaining: Int
    var type: BuffType
    var direction: BuffDirection
    var priority: BuffPriority
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///   - duration: How long the buff is applied for - nil for infinite duration
    ///   - type: What stat the buff affects
    ///   - direction: What direction the buff is applied to, for example, an outgoing damage buff increases damage dealt, but not received
    ///   - priority: What order, relative to other buffs, is this buff applied
    init(effectsDescription: String?, duration: Int?, type: BuffType, direction: BuffDirection, priority: BuffPriority) {
        if let duration = duration {
            self.timeRemaining = duration
            self.effectsDescription = effectsDescription?.continuedBy(Strings.Buff.Duration1Param.localWithArgs(duration))
        }
        else {
            self.timeRemaining = 1
            self.isInfinite = true
            self.effectsDescription = effectsDescription
        }
        self.type = type
        self.direction = direction
        self.priority = priority
    }
    
    /// Indicates what stat the buff affects, and also is used as the indicator for which apply function is overwritten to have effect.
    /// For each type, add a skeleton function in BuffAbstract to be overridden in the buff class.
    enum BuffType {
        case damage
        case health
        case armorPoints
        case price
        case goldBonus
    }
    
    /// What direction the buff is applied to, for example, an outgoing damage buff increases damage dealt, but not received.
    enum BuffDirection {
        case outgoing
        case incoming
        case bidirectional
    }
    
    /// Addition has a priority of 0, multiplication has a priority of 1. This has an effect on the outcome due to the order of operations.
    enum BuffPriority: Int {
        case first = 0
        case second = 1
    }
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    func decrementTimeRemaining() {
        guard !isInfinite else {
            return
        }
        self.timeRemaining -= 1
    }
    
    func applyDamage(to damage: Int, source: Any) -> Int? {
        return nil
    }
    
    func applyHealth(to health: Int, source: Any) -> Int? {
        return nil
    }
    
    func applyArmorPoints(to armorPoints: Int, source: Any) -> Int? {
        return nil
    }
    
    func applyPrice(to gold: Int) -> Int? {
        return nil
    }
    
    func applyGoldBonus(to gold: Int) -> Int? {
        return nil
    }
    
}
