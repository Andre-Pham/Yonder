//
//  SequenceTimer.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

class SequenceTimer {
    
    private var timer: Timer?
    
    deinit {
        // Timers are retained in memory even without reference
        // (That's a waste of resources because if this is deallocated, the timer goes unused)
        // Clean up dependency be invalidating the timer before deallocating this
        self.stop()
    }
    
    /// Start a timer and define a callback that is triggered on every time interval.
    /// IMPORTANT: Use a weak reference to self when defining the closure. Otherwise the closure, parent class, and this instance is retained in memory despite not being stored nor referenced anywhere.
    /// Example:
    /// ```
    /// mySequenceTimer.start(withTimeInterval: 1.0) { [weak self] in
    ///     guard let self = self else { return }
    ///     // Do stuff here
    /// }
    /// ```
    /// - Parameters:
    ///   - timeInterval: The amount of time to pass between every callback trigger
    ///   - callback: The callback to trigger at every time interval
    func start(withTimeInterval timeInterval: TimeInterval, callback: @escaping () -> Void) {
        self.stop()
        self.timer = Timer(timeInterval: timeInterval, repeats: true) { [weak self] timer in
            guard self != nil else {
                timer.invalidate()
                return
            }
            callback()
        }
        // Keep the timer running outside of the view lifecycle
        // (If the view "pauses", e.g. while scrolling, the timer keeps ticking)
        // Without this, scrolling pauses the animation
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
}
