//
//  String.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

extension String {
    
    /// Retrieves the first available Int in a string.
    /// Example:
    /// ``` "a10.b20.0".parseFirstInt() -> 10
    ///     ".x002.50".parseFirstInt() -> 2
    /// ```
    /// - Returns: First Int in a string.
    func parseFirstInt() -> Int? {
        let components = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for component in components {
            if let firstInt = Int(component) {
                return firstInt
            }
        }
        return nil
    }
    
    /// Retrieves the first available and valid Double in a string.
    /// Example:
    /// ``` "a10.b20.0".parseFirstDouble() -> 20.0
    ///     ".1b50a01.0".parseFirstDouble() -> 1.0
    /// ```
    /// - Returns: First Double in a string that must include a decimal point padded by numbers.
    func parseFirstDouble() -> Double? {
        var charSet = CharacterSet.decimalDigits
        charSet.insert(".")
        let components = self.components(separatedBy: charSet.inverted)
        for component in components {
            let isValidDouble = (component.contains(".") &&
                                 component.first != "." &&
                                 component.last != ".")
            if let firstDouble = Double(component), isValidDouble {
                return firstDouble
            }
        }
        return nil
    }
    
    /// Separates a string by an integer embedded in the string. The integer must occur only once.
    /// Example:
    /// ``` "I am 20 years old.".separatedBy(20) -> ("I am ", " years old.")
    /// ```
    /// - Returns: Two strings in a tuple, first from the left side of the Int argument, second from the right side.
    func separatedBy(int: Int) -> (String, String)? {
        let components = self.components(separatedBy: String(int))
        if components.count == 2 {
            return (components[0], components[1])
        }
        assertionFailure("Received a string that doesn't contain a single instance of a specified Int")
        return nil
    }
    
    /// Separates a string by a double embedded in the string. The double must occur only once.
    /// Example:
    /// ``` "a10.b20.0x".separatedBy(20.0) -> ("a10.b", "x")
    /// ```
    /// - Returns: Two strings in a tuple, first from the left side of the Double argument, second from the right side.
    func separatedBy(double: Double) -> (String, String)? {
        let components = self.components(separatedBy: String(double))
        if components.count == 2 {
            return (components[0], components[1])
        }
        assertionFailure("Received a string that doesn't contain a single instance of a specified Double")
        return nil
    }
    
    func lowercaseFirst() -> String {
        if let first = self.first {
            return first.lowercased() + self.dropFirst()
        }
        return self
    }
    
    func continuedBy(_ toJoin: String..., separator: String = " ") -> String {
        return self + separator + toJoin.joined(separator: separator)
    }
    
    func padded(by padding: String) -> String {
        return padding + self + padding
    }
    
    func leftPadded(by padding: String) -> String {
        return padding + self
    }
    
    func rightPadded(by padding: String) -> String {
        return self + padding
    }
    
}
