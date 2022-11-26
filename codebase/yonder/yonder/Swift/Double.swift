//
//  Double.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

extension Double {
    
    func toString(decimalPlaces: Int = 0) -> String {
        return NSString(format: "%.\(decimalPlaces)f" as NSString, self) as String
    }
    
    /// Returns the double as an "increases by"/"decreases by" percentage relative to the magnitude (sans "%").
    /// 0.2 x 10 = 2, so 10 was reduced by 80%, hence the statement that 0.2 "decreases X by 80%".
    /// Example:
    /// ``` 0.541.toRelativePercentage() -> "45.9"
    ///     1.9018.toRelativePercentage(decimalPlaces: 3) -> "90.180"
    /// ```
    /// - Parameters:
    ///   - decimalPlaces: The number of decimal places to be included in the result
    /// - Returns: A string of the double as a percentage.
    func toRelativePercentage(decimalPlaces: Int = 1) -> String {
        return (100.0*abs(1.0 - self)).toString(decimalPlaces: decimalPlaces)
    }
    
    func multiplyingIncreases() -> Bool {
        return self > 1
    }
    
    func multiplyingDecreases() -> Bool {
        return self >= 0 && self < 1
    }
    
    func toRoundedInt() -> Int {
        return Int(Darwin.round(self))
    }
    
    func compound(multiply: Double, index: Double) -> Double {
        return self*pow(multiply, index)
    }
    
    func compound(multiply: Double, index: Int) -> Double {
        return self.compound(multiply: multiply, index: Double(index))
    }
    
    /// Retrieves the nearest double that's a multiple of x.
    /// Example:
    /// ``` 0.32.nearest(0.05) -> 0.3
    ///     0.33.nearest(0.05) -> 0.35
    /// ```
    /// - Parameters:
    ///   - x: The magnitude that the return value has to be a multiple of.
    /// - Returns: The nearest double `y` where `y%x == 0`
    func nearest(_ x: Double) -> Double {
        let decimals = String(x).split(separator: ".")[1]
        let decimalCount = decimals == "0" ? 0 : decimals.count
        let remainder = self.truncatingRemainder(dividingBy: x)
        let divisor = pow(10.0, Double(decimalCount))
        let lower = Darwin.round((self - remainder)*divisor)/divisor
        let upper = Darwin.round((self - remainder)*divisor)/divisor + x
        return (self - lower < upper - self) ? lower : upper
    }
    
    /// Round to x decimal places.
    /// Example: `0.545.rounded(decimalPlaces: 1) -> 0.5`
    /// - Parameters:
    ///   - decimalPlaces: The number of digits after the decimal point
    /// - Returns: The rounded double
    func rounded(decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return Darwin.round(self*multiplier)/multiplier
    }
    
}
