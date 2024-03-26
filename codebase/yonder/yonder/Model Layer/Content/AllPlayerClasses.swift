//
//  AllPlayerClasses.swift
//  yonder
//
//  Created by Andre Pham on 6/12/2022.
//

import Foundation

enum PlayerClassOption  {
    
    case none
    case warrior
    case treasurer
    case mage
    case druid
    case marksman
    case tank
    
    /// Classes that may be selected by the player
    public static var availableOptions: [PlayerClassOption] {
        [.warrior, .marksman, .treasurer, .tank, .druid, .mage]
    }
    
    private var playerClass: PlayerClass {
        switch self {
        case .none: return NoClass()
        case .warrior: return WarriorClass()
        case .treasurer: return TreasurerClass()
        case .mage: return MageClass()
        case .druid: return DruidClass()
        case .marksman: return MarksmanClass()
        case .tank: return TankClass()
        }
    }
    
    public var name: String {
        return self.playerClass.name
    }
    
    public var characterSprite: YonderImage {
        return self.playerClass.characterSprite
    }
    
    func createPlayer(at location: Location) -> Player {
        return self.playerClass.createPlayer(at: location)
    }
    
}
