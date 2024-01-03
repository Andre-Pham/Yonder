//
//  RegionProfileAssignment.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation

enum RegionProfileAssignment: String {
    
    /// The region profile can only be assigned to areas
    case area
    /// The region profile can only be assigned to tavern areas
    case tavernArea
    /// The region profile can be assigned to any
    case any
    
}
