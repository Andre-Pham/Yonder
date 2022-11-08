//
//  Array.swift
//  yonder
//
//  Created by Andre Pham on 7/11/2022.
//

import Foundation

extension Array {
    
    /// Populates this array by repeating a callback.
    /// Example:
    /// ``` var myArray = [Int]()
    ///     myArray.populate(count: 5) {
    ///         Int.random(in: 0...10)
    ///     }
    ///     // myArray = [1, 10, 4, 8, 8]
    ///     myArray.populate(count: 2) {
    ///         Int.random(in: 50...100)
    ///     }
    ///     // myArray = [1, 10, 4, 8, 8, 62, 99]
    /// ```
    /// - Parameters:
    ///   - count: The number of times to repeat the callback
    ///   - callback: The callback which returns an element to be added to the array
    mutating func populate(count: Int, _ callback: () -> Element) {
        for _ in 0..<count {
            self.append(callback())
        }
    }
    
    /// Populates this array by repeating a callback that returns an array.
    /// - Parameters:
    ///   - count: The number of times to repeat the callback
    ///   - callback: The callback which returns an array of elements to be added to the array
    mutating func populateContentsOf(count: Int, _ callback: () -> [Element]) {
        for _ in 0..<count {
            self.append(contentsOf: callback())
        }
    }
    
}
