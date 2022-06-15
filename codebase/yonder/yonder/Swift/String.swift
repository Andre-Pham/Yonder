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
    
}
