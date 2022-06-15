//
//  Localizable.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

// https://www.packt.com/string-management-in-swift/

typealias LocalizeParent = Localizable.Type?
fileprivate let separator = "."

protocol Localizable {
    
    static var parent: LocalizeParent { get } // The enum type of the parent in the enum hierarchy
    var rawValue: String { get } // The enum's type as a string, e.g. enum Car -> "Car"
    
}
/// Provides an interface for retrieving strings from .string files via an enum hierarchy.
/// Example:
/// ``` // Localizable.strings
///     "car.wheels.tireColor" = "Red";
///
///     // Car.swift
///     print(Strings.Car.Wheels.TireColor) // "Red"
/// ```
///
/// Terminology:
/// Referring to `"car.wheels.tireColor" = "Red";`
/// `"car.wheels"` is the "key path"
/// `"tireColor"` is the "key value"
/// `"car.wheels.tireColor"` is the "key"
extension Localizable {
    
    private static func appendToKeyPath(keyPath: String?, keyValue: String) -> String {
        guard let keyPath = keyPath else {
            return keyValue.lowercaseFirst()
        }
        return keyPath + separator + keyValue.lowercaseFirst()
    }
    
    private static var keyPath: String {
        return appendToKeyPath(keyPath: self.parent?.parentKeyValue, keyValue: self.parentKeyValue)
    }
    
    private static var parentKeyValue: String {
        return "\(self)"
    }
    
    private var keyValue: String {
        return self.rawValue
    }
    
    private var key: String {
        let key = Self.appendToKeyPath(keyPath: Self.keyPath, keyValue: self.keyValue)
        // This way we don't have to write the root enum name at the beginning of every key
        let firstSeparatorIndex = key.range(of: separator)!.upperBound
        return String(key.suffix(from: firstSeparatorIndex))
    }
    
    var local: String {
        return NSLocalizedString(key, comment: "")
    }
    
    /// Retrieves a localized with arguments inserted into "%@" positions.
    /// - Parameters:
    ///   - args: The arguments to replace the "%@" instances in the localized string (up to 6)
    /// - Returns: The localized string
    func localWithArgs(_ args: String...) -> String {
        switch args.count {
            case 0: return self.local
            case 1: return String(format: self.local, args[0])
            case 2: return String(format: self.local, args[0], args[1])
            case 3: return String(format: self.local, args[0], args[1], args[2])
            case 4: return String(format: self.local, args[0], args[1], args[2], args[3])
            case 5: return String(format: self.local, args[0], args[1], args[2], args[3], args[4])
            case 6: return String(format: self.local, args[0], args[1], args[2], args[3], args[4], args[5])
            default: return self.local
        }
    }
    
}






