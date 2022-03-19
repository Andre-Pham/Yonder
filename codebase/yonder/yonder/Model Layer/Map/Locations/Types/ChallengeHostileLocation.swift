//
//  ChallengeHostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ChallengeHostileLocation: LocationAbstract, FoeLocation {
    
    private(set) var foe: Foe
    public let type: LocationType = .challengeHostile
    
    init(foe: Foe) {
        self.foe = foe
    }
    
}
