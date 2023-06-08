//
//  Timer.swift
//  Animation
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

class CustomTimer {
    private var timer: Timer?
    private var callback: (() -> Void)?
    
    deinit {
        // TODO: I don't know if this is necessary
        self.timer?.invalidate()
    }
    
    func start(withTimeInterval timeInterval: TimeInterval, callback: @escaping () -> Void) {
        stop()
        
        self.callback = callback
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        callback = nil
    }
    
    @objc private func timerCallback() {
        callback?()
    }
}
