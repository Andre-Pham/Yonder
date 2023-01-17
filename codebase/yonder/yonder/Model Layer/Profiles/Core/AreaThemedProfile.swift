//
//  AreaThemedProfile.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

protocol AreaThemedProfile {
    
    var regionTags: [RegionProfileTag] { get }
    
}
extension AreaThemedProfile {
    
    func matchesAreaTag(_ areaTag: RegionProfileTag) -> Bool {
        return self.regionTags.contains(where: { $0 == areaTag }) || self.regionTags.contains(where: { $0 == .all })
    }
    
}
