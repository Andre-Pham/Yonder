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
    
}
