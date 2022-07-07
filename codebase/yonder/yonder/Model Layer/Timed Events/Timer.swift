//
//  Timer.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class Timer {
    
    private(set) var timeLeft: Int
    var isFinished: Bool {
        return self.timeLeft <= 0
    }
    
    init(startTime: Int) {
        self.timeLeft = startTime
    }
    
    func tickDown() {
        self.timeLeft -= 1
    }
    
}
