//
//  TimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

typealias TimedEventAbstract = TimedEventPart & EffectsDescribed & TracksTimer & PossibleIndicativeValue

class TimedEventPart: Named, Clonable {
    
    public let name: String
    public let id = UUID()
    
    init(name: String) {
        self.name = name
    }
    
    required init(_ original: TimedEventPart) {
        self.name = original.name
    }
    
}
