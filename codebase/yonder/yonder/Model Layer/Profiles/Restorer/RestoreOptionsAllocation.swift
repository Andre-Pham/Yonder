//
//  RestoreOptionsAllocation.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestoreOptionsAllocation {
    
    public let optionsCode: String
    
    init(options: [Restorer.RestoreOption]) {
        self.optionsCode = options.map({ $0.id.uuidString }).sorted(by: { $0 < $1 }).joined(separator: ".")
    }
    
}
