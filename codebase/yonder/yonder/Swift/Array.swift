//
//  Array.swift
//  yonder
//
//  Created by Andre Pham on 7/11/2022.
//

import Foundation

extension Array {
    
    /// Instantiate the array populating it by repeating a callback.
    /// - Parameters:
    ///   - count: The number of times to repeat the callback
    ///   - callback: The callback which returns an element to be added to the array
    public init(count: Int, populateWith: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in populateWith() }
    }
    
    /// Count how many elements meet a condition.
    /// - Parameters:
    ///   - condition: The condition to test
    /// - Returns: The number of elements that meet the provided condition
    func count(where condition: (_ element: Element) -> Bool) -> Int {
        var tally = 0
        for element in self {
            if (condition(element)) {
                tally += 1
            }
        }
        return tally
    }
    
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
    
    /// Take the last x elements from the array (removes the elements).
    /// Example:
    /// ``` var myArray = [1, 2, 3, 4, 5]
    ///     myArray.takeFirst(3) -> [1, 2, 3]
    ///     // myArray = [4, 5]
    /// ```
    /// - Parameters:
    ///   - count: The number of elements to take
    /// - Returns: The last x elements
    mutating func takeFirst(_ count: Int) -> [Element] {
        assert(self.count >= count, "Attempting to take more elements than what exists in the array")
        let result = Array(self[0..<count])
        self = Array(self.dropFirst(count))
        return result
    }
    
    /// Take the first x elements from the array (removes the elements).
    /// Example:
    /// ``` var myArray = [1, 2, 3, 4, 5]
    ///     myArray.takeLast(3) -> [3, 4, 5]
    ///     // myArray = [1, 2]
    /// ```
    /// - Parameters:
    ///   - count: The number of elements to take
    /// - Returns: The first x elements
    mutating func takeLast(_ count: Int) -> [Element] {
        assert(self.count >= count, "Attempting to take more elements than what exists in the array")
        let result = Array(self[(self.count - count)..<(self.count)])
        self = self.dropLast(count)
        return result
    }
    
    mutating func appendToFront(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    mutating func appendToFront(contentsOf: [Element]) {
        self.insert(contentsOf: contentsOf, at: 0)
    }
    
}
