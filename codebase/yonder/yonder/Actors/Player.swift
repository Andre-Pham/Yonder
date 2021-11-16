//
//  Player.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Player: ActorAbstract {
    
    private(set) var armor: Int = 0
    
    override init(maxHealth: Int) {
        super.init(maxHealth: maxHealth)
    }
    
}
