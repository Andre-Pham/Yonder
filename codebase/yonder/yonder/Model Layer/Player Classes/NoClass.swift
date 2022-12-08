//
//  NoClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

class NoClass: PlayerClass {
    
    init() {
        super.init(name: "No Class")
    }
    
    func createPlayer(at location: Location) -> Player {
        return Player(maxHealth: 500, location: location)
    }
    
}
