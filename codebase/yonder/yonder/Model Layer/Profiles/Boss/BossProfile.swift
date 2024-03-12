//
//  BossProfile.swift
//  yonder
//
//  Created by Andre Pham on 30/11/2022.
//

import Foundation

class BossProfile: AreaThemedProfile {
    
    public let id: String
    public let bossName: String
    public let bossDescription: String
    public let regionTags: [RegionProfileTag]
    
    init(id: String, bossName: String, bossDescription: String, regionTags: [RegionProfileTag]) {
        self.id = id
        self.bossName = bossName
        self.bossDescription = bossDescription
        self.regionTags = regionTags
    }
    
}
