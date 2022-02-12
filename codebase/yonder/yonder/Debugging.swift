//
//  Debugging.swift
//  yonder
//
//  Created by Andre Pham on 16/12/21.
//

import Foundation

enum YonderDebugging {
    
    /// Formats a print statement to console used for detecting unexpected errors during runtime.
    ///
    /// Example:
    /// `YonderDebugging.printError(message: "Hexagon coordinate has been set more than once, which shouldn't be occuring", functionName: #function, className: "\(type(of: self))")`
    static func printError(message: String, functionName: String, className: String) {
        let message = "\nERROR [\(className).\(functionName)]: \(message)"
        print(message)
    }
    
}
