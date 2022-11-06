//
//  Random.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import GameKit

enum Random {
    
    /// Randomly returns true with a "x in y" chance.
    /// Example:
    /// ``` Random.roll(1, in: 5) // Has a 1/5 chance of returning true ```
    /// - Parameters:
    ///   - numerator: The numerator of the probability fraction
    ///   - denominator: The denominator of the probability fraction
    /// - Returns: true or false depending on the roll
    static func roll(_ numerator: Int, in denominator: Int) -> Bool {
        assert(numerator <= denominator, "Invalid probability is over 100%")
        let output = Int.random(in: 1...denominator)
        return output <= numerator
    }
    
    static func selectFromNormalDistribution(min: Int, max: Int) -> Int {
        return GKGaussianDistribution(lowestValue: min, highestValue: max).nextInt()
    }
    
    static func selectFromNormalDistribution(mid: Int, boundMidDifference: Int) -> Int {
        let boundMidDifference = abs(boundMidDifference)
        return Self.selectFromNormalDistribution(min: mid - boundMidDifference, max: mid + boundMidDifference)
    }
    
    static func selectFromNormalDistribution(mid: Int, boundFraction: Double) -> Int {
        let boundMidDifference = (Double(mid)*boundFraction).toRoundedInt()
        return Self.selectFromNormalDistribution(min: mid - boundMidDifference, max: mid + boundMidDifference)
    }
    
}
