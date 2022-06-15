//
//  ArmorAttribute.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation

enum ArmorAttribute {
    
    case upgradesDisallowed
    
    var description: String? {
        switch self {
        case .upgradesDisallowed:
            return nil // E.g. "Can't receive upgrades"
        }
    }
    
}
