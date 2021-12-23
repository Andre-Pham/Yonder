//
//  TavernAreaArrangements.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

enum TavernAreaArrangements: CaseIterable {
    
    case A; case B; case C; case D
    
    var locationCount: Int {
        switch self {
        case .A: return 6
        case .B: return 5
        case .C: return 4
        case .D: return 3
        }
    }
    
}
