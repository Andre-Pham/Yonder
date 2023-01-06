//
//  TestPerformance.swift
//  yonder
//
//  Created by Andre Pham on 5/1/2023.
//

import Foundation

enum TestPerformance {
    
    @discardableResult
    static func executionDuration(taskName: String, _ test: () -> Void) -> Double {
        let start = DispatchTime.now()
        test()
        let end = DispatchTime.now()
        let seconds = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/1_000_000_000
        print("> \(taskName) execution lasted: \(seconds) seconds")
        return seconds
    }
    
}
