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
    case alchemist
    case mage
    case warlock
    case druid
    case cleric
    case paladin
    
    /// Classes that may be selected by the player
    public static var availableOptions: [PlayerClassOption] {
        [.warrior, .treasurer, .alchemist]
    }
    
    private var playerClass: PlayerClass {
        switch self {
        case .none: return NoClass()
        case .warrior: return WarriorClass()
        case .treasurer: return TreasurerClass()
        case .alchemist: return AlchemistClass()
        case .mage: return MageClass()
        case .warlock: return WarlockClass()
        case .cleric: return ClericClass()
        case .paladin: return PaladinClass()
        case .druid: return DruidClass()
        }
    }
    
    public var name: String {
        return self.playerClass.name
    }
    
    func createPlayer(at location: Location) -> Player {
        return self.playerClass.createPlayer(at: location)
    }
    
}
