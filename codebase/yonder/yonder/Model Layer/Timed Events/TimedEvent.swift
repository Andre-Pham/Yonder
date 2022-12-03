//
//  TimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

typealias TimedEvent = TimedEventAbstract & EffectsDescribed & TracksTimer & PossibleIndicativeValue

class TimedEventAbstract: Named, Clonable, Storable {
    
    public let name: String
    public let id = UUID()
    
    init(name: String) {
        self.name = name
    }
    
    required init(_ original: TimedEventAbstract) {
        self.name = original.name
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
    }
    
}
