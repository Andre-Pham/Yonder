//
//  AllFoes.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

enum Foes {
    
    // MARK: - Test Foes
    
    static func newTestFoe() -> FoeAbstract {
        return FoeAbstract(maxHealth: 200, weapon: BaseAttack(damage: 100))
    }
    
}
