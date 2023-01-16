//
//  AccessoryProfile.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class AccessoryProfile: AreaThemedProfile {
    
    public let id: Int
    public let accessoryName: String
    public let accessoryDescription: String
    public let areaTags: [AreaProfileTag]
    public let accessoryTag: AccessoryProfileTag
    public let accessoryType: AccessoryType
    
    init(id: Int, accessoryName: String, accessoryDescription: String, areaTags: [AreaProfileTag], accessoryTag: AccessoryProfileTag, accessoryType: AccessoryType) {
        self.id = id
        self.accessoryName = accessoryName
        self.accessoryDescription = accessoryDescription
        self.areaTags = areaTags
        self.accessoryTag = accessoryTag
        self.accessoryType = accessoryType
    }
    
}
