//
//  Strings.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

struct Strings {
    
    public let local: String
    
    init(_ path: String) {
        self.local = NSLocalizedString(path, comment: "")
        assert(self.local != path, "String path \"\(path)\" has no matching string.")
    }
    
    /// Retrieves a localized string with String arguments inserted into "%@" positions.
    /// - Parameters:
    ///   - args: The String arguments to replace the "%@" instances in the localized string (up to 6)
    /// - Returns: The localized string
    func localWithArgs(_ args: String...) -> String {
        self.formatArgs(args)
    }

    /// Retrieves a localized string with Int arguments inserted into "%@" positions.
    /// - Parameters:
    ///   - args: The Int arguments to replace the "%@" instances in the localized string (up to 6)
    /// - Returns: The localized string
    func localWithArgs(_ args: Int...) -> String {
        self.formatArgs(args.map { String($0) })
    }

    /// Formats string arguments into a localized string by replacing the "%@" instances with said arguments.
    /// - Parameters:
    ///   - args: The String arguments to replace the "%@" instances in the localized string (up to 6)
    /// - Returns: The localized string
    private func formatArgs(_ args: [String]) -> String {
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
