//
//  TestPerformance.swift
//  yonder
//
//  Created by Andre Pham on 5/1/2023.
//

import Foundation

@discardableResult
func testExecutionDuration(printedTaskName: String? = nil, _ test: () -> Void) -> Double {
    #if DEBUG
    let start = DispatchTime.now()
    test()
    let end = DispatchTime.now()
    let seconds = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/1_000_000_000
    if let printedTaskName {
        print("> \(printedTaskName) execution lasted: \(seconds) seconds")
    }
    return seconds
    #else
    return 0.0
    #endif
}
