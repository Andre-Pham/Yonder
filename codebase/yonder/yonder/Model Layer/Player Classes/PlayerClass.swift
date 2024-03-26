//
//  PlayerClass.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation

typealias PlayerClass = PlayerClassAbstract & PlayerClassProtocol

protocol PlayerClassProtocol {
    
    func createPlayer(at location: Location) -> Player
    
}

class PlayerClassAbstract {
    
    public let name: String
    public let characterSprite: YonderImage
    
    init(name: String, characterSprite: YonderImage) {
        self.name = name
        self.characterSprite = characterSprite
    }
    
}
