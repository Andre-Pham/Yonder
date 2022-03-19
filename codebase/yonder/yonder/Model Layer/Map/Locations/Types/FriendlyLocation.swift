//
//  FriendlyLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class FriendlyLocation: LocationAbstract {
    
    private(set) var friendly: Friendly
    public let type: LocationType = .friendly
    
    init(friendly: Friendly) {
        self.friendly = friendly
    }
    
}
