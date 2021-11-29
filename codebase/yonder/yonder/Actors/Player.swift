//
//  Player.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Player: ActorAbstract {
    
    private(set) var location: Location
    
    init(maxHealth: Int, location: Location) {
        self.location = location
        
        super.init(maxHealth: maxHealth)
    }
    
}
