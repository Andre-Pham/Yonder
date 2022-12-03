//
//  Timer.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class Timer: Clonable, Storable {
    
    @DidSetPublished private(set) var timeLeft: Int
    public let initialTime: Int
    var isFinished: Bool {
        return self.timeLeft <= 0
    }
    
    init(startTime: Int) {
        self.timeLeft = startTime
        self.initialTime = startTime
    }
    
    required init(_ original: Timer) {
        self.timeLeft = original.timeLeft
        self.initialTime = original.initialTime
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case timeLeft
        case initialTime
    }

    required init(dataObject: DataObject) {
        self.timeLeft = dataObject.get(Field.timeLeft.rawValue)
        self.initialTime = dataObject.get(Field.initialTime.rawValue)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.timeLeft.rawValue, value: self.timeLeft)
            .add(key: Field.initialTime.rawValue, value: self.initialTime)
    }

    // MARK: - Functions
    
    func tickDown() {
        self.timeLeft -= 1
    }
    
}
