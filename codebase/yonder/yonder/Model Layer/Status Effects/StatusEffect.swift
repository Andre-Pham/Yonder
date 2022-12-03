//
//  StatusEffect.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

typealias StatusEffect = StatusEffectAbstract & EffectsDescribed & AppliesEffect & PossibleIndicativeValue

class StatusEffectAbstract: Named, Clonable, Storable {
    
    public let name: String
    @DidSetPublished private(set) var timeRemaining: Int
    public let initialTimeRemaining: Int
    public let id = UUID()
    
    init(name: String, duration: Int) {
        self.name = name
        self.timeRemaining = duration
        self.initialTimeRemaining = duration
    }
    
    required init(_ original: StatusEffectAbstract) {
        self.name = original.name
        self.timeRemaining = original.timeRemaining
        self.initialTimeRemaining = original.initialTimeRemaining
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case timeRemaining
        case initialTimeRemaining
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.timeRemaining = dataObject.get(Field.timeRemaining.rawValue)
        self.initialTimeRemaining = dataObject.get(Field.initialTimeRemaining.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.timeRemaining.rawValue, value: self.timeRemaining)
            .add(key: Field.initialTimeRemaining.rawValue, value: self.initialTimeRemaining)
    }

    // MARK: - Functions
    
    func decrementTimeRemaining() {
        self.timeRemaining -= 1
    }
    
}
