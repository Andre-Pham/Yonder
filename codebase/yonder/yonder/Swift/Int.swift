//
//  Int.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation

extension Int {
    
    /// Retrieves the nearest integer that's a multiple of x.
    /// Example:
    /// ``` 451.nearest(10) -> 450
    ///     450.nearest(100) -> 500
    ///     499.nearest(1000) -> 0
    /// ```
    /// - Parameters:
    ///   - x: The magnitude that the return value has to be a multiple of.
    /// - Returns: The nearest integer `y` where `y%x == 0`
    func nearest(_ x: Int) -> Int {
        let lowerBound = (self/x)*x
        return self - lowerBound > x/2 - 1 ? lowerBound + x : lowerBound
    }
    
}
