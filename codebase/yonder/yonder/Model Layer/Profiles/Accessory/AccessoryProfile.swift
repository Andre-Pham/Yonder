//
//  AccessoryProfile.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class AccessoryProfile: AreaThemedProfile {
    
    public let id: String
    public let accessoryName: String
    public let regionTags: [RegionProfileTag]
    public let accessoryTag: AccessoryProfileTag
    public let accessoryType: AccessoryType
    
    init(id: String, accessoryName: String, regionTags: [RegionProfileTag], accessoryTag: AccessoryProfileTag, accessoryType: AccessoryType) {
        self.id = id
        self.accessoryName = accessoryName
        self.regionTags = regionTags
        self.accessoryTag = accessoryTag
        self.accessoryType = accessoryType
    }
    
}
