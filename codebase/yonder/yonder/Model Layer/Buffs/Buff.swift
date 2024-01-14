//
//  File.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

typealias Buff = BuffAbstract & HasPriceValue

class BuffAbstract: EffectsDescribed, Clonable, Storable {
    
    private(set) var sourceName: String
    private let effectsDescription: String?
    var isInfinite: Bool {
        return self.timeRemaining == nil
    }
    @DidSetPublished var timeRemaining: Int?
    public let initialTimeRemaining: Int?
    var type: BuffType
    var direction: BuffDirection
    var priority: BuffPriority
    public let id: UUID
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///   - sourceName: The source that applied this buff
    ///   - duration: How long the buff is applied for - nil for infinite duration
    ///   - type: What stat the buff affects
    ///   - direction: What direction the buff is applied to, for example, an outgoing damage buff increases damage dealt, but not received
    ///   - priority: What order, relative to other buffs, is this buff applied
    init(sourceName: String, effectsDescription: String?, duration: Int?, type: BuffType, direction: BuffDirection, priority: BuffPriority) {
        self.id = UUID()
        self.sourceName = sourceName
        self.timeRemaining = duration
        self.initialTimeRemaining = duration
        if let timeRemaining = duration {
            self.effectsDescription = effectsDescription?.continuedBy(Strings("buff.duration1Param").localWithArgs(timeRemaining))
        } else {
            // Infinite duration
            self.effectsDescription = effectsDescription
        }
        self.type = type
        self.direction = direction
        self.priority = priority
    }
    
    required init(_ original: BuffAbstract) {
        self.id = UUID()
        self.sourceName = original.sourceName
        self.timeRemaining = original.timeRemaining
        self.initialTimeRemaining = original.initialTimeRemaining
        self.effectsDescription = original.effectsDescription
        self.type = original.type
        self.direction = original.direction
        self.priority = original.priority
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case id
        case sourceName
        case timeRemaining
        case initialTimeRemaining
        case effectsDescription
        case type
        case direction
        case priority
    }

    required init(dataObject: DataObject) {
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        self.sourceName = dataObject.get(Field.sourceName.rawValue)
        self.timeRemaining = dataObject.get(Field.timeRemaining.rawValue)
        self.initialTimeRemaining = dataObject.get(Field.initialTimeRemaining.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        // If any of these fail it's pretty much game over, just bail
        self.type = BuffType(rawValue: dataObject.get(Field.type.rawValue))!
        self.direction = BuffDirection(rawValue: dataObject.get(Field.direction.rawValue))!
        self.priority = BuffPriority(rawValue: dataObject.get(Field.priority.rawValue))!
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.id.rawValue, value: self.id.uuidString)
            .add(key: Field.sourceName.rawValue, value: self.sourceName)
            .add(key: Field.timeRemaining.rawValue, value: self.timeRemaining)
            .add(key: Field.initialTimeRemaining.rawValue, value: self.initialTimeRemaining)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.type.rawValue, value: self.type.rawValue)
            .add(key: Field.direction.rawValue, value: self.direction.rawValue)
            .add(key: Field.priority.rawValue, value: self.priority.rawValue)
    }

    // MARK: - Enums
    
    /// Indicates what stat the buff affects, and also is used as the indicator for which apply function is overwritten to have effect.
    /// For each type, add a skeleton function in BuffAbstract to be overridden in the buff class.
    enum BuffType: String {
        case damage
        case health
        case armorPoints
        /// Price and gold bonus can't be merged into a single "gold buff".
        /// This is because there is no "owner" and "target"; there is no buff direction, and only the player will have gold buffs to apply. So this means if you had a buff that increased prices, its apply method would increase all gold transactions, meaning the player's received gold would also increase along with prices.
        case price
        case goldBonus
    }
    
    /// What direction the buff is applied to, for example, an outgoing damage buff increases damage dealt, but not received.
    enum BuffDirection: String {
        case outgoing
        case incoming
        case bidirectional
    }
    
    /// Addition has a priority of 0, multiplication has a priority of 1. This has an effect on the outcome due to the order of operations.
    enum BuffPriority: Int {
        case first = 0
        case second = 1
    }
    
    // MARK: - Functions
    
    func getEffectsDescription() -> String? {
        return self.effectsDescription
    }
    
    func updateSource(to sourceName: String) {
        self.sourceName = sourceName
    }
    
    func decrementTimeRemaining() {
        guard !isInfinite else {
            return
        }
        self.timeRemaining! -= 1
    }
    
    func applyDamage(to damage: Int, source: Any) -> Int {
        return damage
    }
    
    func applyHealth(to health: Int, source: Any) -> Int {
        return health
    }
    
    func applyArmorPoints(to armorPoints: Int, source: Any) -> Int {
        return armorPoints
    }
    
    func applyPrice(to gold: Int) -> Int {
        return gold
    }
    
    func applyGoldBonus(to gold: Int) -> Int {
        return gold
    }
    
}
