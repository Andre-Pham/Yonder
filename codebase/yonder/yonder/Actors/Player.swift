//
//  Player.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Player: ActorAbstract {
    
    private(set) var location: LocationAbstract
    private(set) var gold = 0
    
    init(maxHealth: Int, location: LocationAbstract) {
        self.location = location
        
        super.init(maxHealth: maxHealth)
    }
    
    func adjustGold(by amount: Int) {
        self.gold += amount
    }
    
}
