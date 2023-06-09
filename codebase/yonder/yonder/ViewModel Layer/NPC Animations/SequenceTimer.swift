//
//  SequenceTimer.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

class SequenceTimer {
    
    private var timer: Timer?
    private var timeIntervalCallback: (() -> Void)?
    
    deinit {
        // TODO: I don't know if this is necessary
        // I just added it because timers (in general) have a tendency to continue calling even after the object gone
        self.timer?.invalidate()
    }
    
    func start(withTimeInterval timeInterval: TimeInterval, callback: @escaping () -> Void) {
        self.stop()
        self.timeIntervalCallback = callback
        self.timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(self.onTimeInterval),
            userInfo: nil,
            repeats: true
        )
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        self.timeIntervalCallback = nil
    }
    
    @objc private func onTimeInterval() {
        self.timeIntervalCallback?()
    }
    
}
