//
//  ArmorProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorProfile: AreaThemedProfile {
    
    public let id: String
    public let armorName: String
    public let regionTags: [RegionProfileTag]
    public let armorTag: ArmorProfileTag
    public let armorType: ArmorType
    
    init(id: String, armorName: String, regionTags: [RegionProfileTag], armorTag: ArmorProfileTag, armorType: ArmorType) {
        self.id = id
        self.armorName = armorName
        self.regionTags = regionTags
        self.armorTag = armorTag
        self.armorType = armorType
    }
    
}
