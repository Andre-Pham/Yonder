//
//  ChallengeHostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ChallengeHostileLocation: LocationAbstract {
    
    private(set) var foe: FoeAbstract
    public let type: LocationType = .challengeHostile
    
    init(foe: FoeAbstract) {
        self.foe = foe
    }
    
}
