//
//  RandomProfile.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

class RandomProfile {
    
    public let name: String
    public let description: String
    
    init(prefix: String) {
        let num = Int.random(in: 0...999)
        self.name = "\(prefix) Name \(num)"
        self.description = "\(prefix) description \(num)."
    }
    
}
