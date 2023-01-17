//
//  ArmorProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorProfile: AreaThemedProfile {
    
    public let id: Int
    public let armorName: String
    public let armorDescription: String
    public let regionTags: [RegionProfileTag]
    public let armorTag: ArmorProfileTag
    public let armorType: ArmorType
    
    init(id: Int, armorName: String, armorDescription: String, regionTags: [RegionProfileTag], armorTag: ArmorProfileTag, armorType: ArmorType) {
        self.id = id
        self.armorName = armorName
        self.armorDescription = armorDescription
        self.regionTags = regionTags
        self.armorTag = armorTag
        self.armorType = armorType
    }
    
}
