//
//  Timer.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class Timer: Clonable {
    
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
    
    func tickDown() {
        self.timeLeft -= 1
    }
    
}
