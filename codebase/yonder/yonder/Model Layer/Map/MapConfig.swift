//
//  MapConfig.swift
//  yonder
//
//  Created by Andre Pham on 30/11/2022.
//

import Foundation

enum MapConfig {
    
    static let territoriesPerBoss = 2
    static let bossCount = 4
    static var territoryCount: Int { Self.bossCount*Self.territoriesPerBoss }
    
}
