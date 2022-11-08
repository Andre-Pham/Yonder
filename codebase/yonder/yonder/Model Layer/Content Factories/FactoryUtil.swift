//
//  FactoryUtil.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

/// A utility class for the content factories.
enum FactoryUtil {
    
    /// Creates a linear sequence of integers in an array.
    /// Example:
    /// ``` createLinearSequence(start: 0, end: 30, count: 4) -> [0, 10, 20, 30]
    ///     createLinearSequence(start: 50, end: 10, count: 3) -> [50, 30, 10]
    /// ```
    /// - Parameters:
    ///   - start: Start of sequence
    ///   - end: End of sequence
    ///   - count: Length of sequence
    /// - Returns: Sequence of integers that grow/shrink linearly
    static func createLinearSequence(start: Int, end: Int, count: Int) -> [Int] {
        let step = (start - end)/(count - 1)
        var sequence = [Int]()
        for index in 0..<count {
            sequence.append(start - step*index)
        }
        return sequence
    }
    
    /// Randomly selects a position in the provided array, where the value at each position is the weight of that position being chosen.
    /// Example:
    /// ``` // On average for every time 0 is returned, 1 is returned 5 times and 2 is returned 10 times
    ///     randomWeightedIndex([1, 5, 10])
    /// ```
    /// - Parameters:
    ///   - weights: The relative weights of each index that can be returned
    /// - Returns: A randomly selected position from the provided argument,  where each position has a weighted chance of being selected
    static func randomWeightedIndex(_ weights: [Int]) -> Int {
        let sum = weights.reduce(0, +)
        let outcome = Int.random(in: 1...sum)
        var leftBound = 0
        for index in 0..<weights.count {
            let range = (leftBound + 1)...(leftBound + weights[index])
            if range ~= outcome {
                return index
            }
            leftBound += weights[index]
        }
        assertionFailure("Reaching end of method should be impossible, either no weights or negative weights were provided")
        return 0
    }
    
}

