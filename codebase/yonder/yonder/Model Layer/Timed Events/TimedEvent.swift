//
//  TimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

typealias TimedEvent = TimedEventAbstract & EffectsDescribed & TracksTimer & PossibleIndicativeValue

class TimedEventAbstract: Named, Clonable {
    
    public let name: String
    public let id = UUID()
    
    init(name: String) {
        self.name = name
    }
    
    required init(_ original: TimedEventAbstract) {
        self.name = original.name
    }
    
}
