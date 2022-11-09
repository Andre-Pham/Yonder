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
    
    /// Randomly returns a double between the min and max where the probability of selecting a value is proportional to it's height in a linear distribution.
    /// - Parameters:
    ///   - min: The minimum returnable value
    ///   - max: The maximum returnable value
    ///   - minY: The height of the distribution at x = `min`
    ///   - maxY: The height of the distribution at x = `max`
    /// - Returns:
    ///   - A double between `min` and `max`
    static func selectFromLinearDistribution(min: Double, max: Double, minY: Double, maxY: Double) -> Double {
        // Steps:
        // 1. Create a polygon with the points (min, 0), (min, minY), (max, maxY), (max, 0)
        // 2. Select a random point on this polygon (note the side with the higher Y is more likely to be chosen)
        // 3. Return the x coordinate of the randomly selected point
        
        let leftPoint = (min, minY)
        let rightPoint = (max, maxY)
        let rectHeight = Double.minimum(minY, maxY)
        let triangleHeight = Double.maximum(minY, maxY) - rectHeight
        let randomPoint = (Double.random(in: min...max), Double.random(in: 0...(rectHeight + triangleHeight/2)))
        // Linear equation (y = m*x + c) for the hypotenuse of the triangle
        let m = (maxY - minY)/(max - min)
        let c = minY - min*m
        // Find y, where the x coordinate of the random point lies on the linear equation
        let y = m*randomPoint.0 + c
        if y < randomPoint.1 {
            // Random point lies on the rectangle/triangle polygon
            return randomPoint.0
        } else {
            // Random point needs to be translated - we only care about its x value
            return randomPoint.0 - 2*(randomPoint.0 - (max + min)/2)
        }
    }
    
}
