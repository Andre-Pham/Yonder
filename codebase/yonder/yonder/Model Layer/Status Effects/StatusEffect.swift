//
//  StatusEffect.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

typealias StatusEffectAbstract = StatusEffectPart & EffectsDescribed & AppliesEffect & PossibleIndicativeValue

class StatusEffectPart: Named, Clonable {
    
    public let name: String
    @DidSetPublished private(set) var timeRemaining: Int
    public let initialTimeRemaining: Int
    public let id = UUID()
    
    init(name: String, duration: Int) {
        self.name = name
        self.timeRemaining = duration
        self.initialTimeRemaining = duration
    }
    
    required init(_ original: StatusEffectPart) {
        self.name = original.name
        self.timeRemaining = original.timeRemaining
        self.initialTimeRemaining = original.initialTimeRemaining
    }
    
    func decrementTimeRemaining() {
        self.timeRemaining -= 1
    }
    
}
