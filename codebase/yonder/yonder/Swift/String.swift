//
//  String.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

extension String {
    
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
