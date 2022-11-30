//
//  AreaThemedProfile.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

protocol AreaThemedProfile {
    
    var areaTags: [AreaProfileTag] { get }
    
}
extension AreaThemedProfile {
    
    func matchesAreaTag(_ areaTag: AreaProfileTag) -> Bool {
        return self.areaTags.contains(where: { $0 == areaTag }) || self.areaTags.contains(where: { $0 == .all })
    }
    
}
