//
//  EnhancerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class EnhancerLocation: LocationAbstract {
    
    private(set) var enhancer: Enhancer
    public let type: LocationType = .enhancer
    
    init(enhancer: Enhancer) {
        self.enhancer = enhancer
    }
    
}
